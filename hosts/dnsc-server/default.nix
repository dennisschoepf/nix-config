{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules/ups
    ../../modules/openssh
    ../../modules/jellyfin
    ../../modules/syncthing
  ];

  # General
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = [ "main" ];

  # Secrets
  age = {
    identityPaths = [ "${config.users.users.dennis.home}/.ssh/id_ed25519" ];
    secrets."restic/password".file = ../../secrets/restic/password.age;
  };

  # Nix Settings
  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;

  # Launch fish shell
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Networking
  networking.hostName = "dnsc-server";
  networking.hostId = "380f584e";
  networking.networkmanager.enable = true;
  # Fix due to https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    8384 # Syncthing GUI
    22000 # Syncthing
  ];
  networking.firewall.allowedUDPPorts = [
    22000 # Syncthing
    21027 # Syncthing
  ];

  # My user account
  users.users.dennis = {
    description = "dennis";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvXWZOPOJJDAoF+Sx/ZLoAVu6G/7/MAWoknBgMAzjul dennis@dnsc-mac"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKnmuxDkpDIku5t1Tykz21u78xoQ7LJR8JEcfth32LGu dennis@dnsc-work"
    ];
  };

  security.sudo.enable = true;

  # Home Manager Setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    users = {
      dennis = import ../../home/server.nix;
    };
  };

  # Enable new Nix CLI and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Install system wide packages
  environment.systemPackages = with pkgs; [
    git
    btop
    neovim
    wget
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    usbutils
    restic
  ];

  # Programs
  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Root SSH
  programs.ssh.extraConfig = ''
    Host dnsc-storage
      Port 23
      IdentitiesOnly yes
      User u295965
      HostName u295965.your-storagebox.de
      IdentityFile /root/.ssh/id_ed25519
  '';

  # Services
  # ZFS
  services.zfs = {
    autoSnapshot.enable = true;
    trim.enable = true;
  };

  # Samba
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.178. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "share" = {
        "path" = "/main/share";
        "browseable" = "yes";
        "writeable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "force user" = "dennis";
        "force group" = "users";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # Backups
  services.restic.backups = {
    "dnsc-storage" = {
      initialize = true;
      passwordFile = config.age.secrets."restic/password".path;
      repository = "sftp:dnsc-storage:restic/dnsc-server";
      paths = [
        "/home/dennis/notes"
        "/main/share"
      ];
      pruneOpts = [
        "--keep-last 3"
      ];
      timerConfig = {
        onCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "5h";
      };
    };
  };

  # Environment variables
  environment.variables.EDITOR = "nvim";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11";
}
