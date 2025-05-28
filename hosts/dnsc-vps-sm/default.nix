{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.ip-whitelist.nixosModules.default
  ];

  # Secrets
  age = {
    identityPaths = [ "${config.users.users.dennis.home}/.ssh/id_ed25519" ];
    secrets."vaultwarden/env".file = ../../secrets/vaultwarden/env.age;
  };

  # Generated automatically
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  # General
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Nix Settings
  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;

  # Networking
  networking.hostName = "dnsc-vps-sm";
  networking.hostId = "380f585f";
  networking.domain = "dnsc.io";
  networking.networkmanager.enable = true;
  # Fix due to https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80 
      443
    ];
    ipBasedAllowedTCPPorts = [
      {
        port = 22;
        ips = [
          "100.103.199.4"
          "100.115.100.87"
          "100.83.40.63"
        ];
      }
    ];
  };
  

  # My user account
  users.users.dennis = {
    description = "dennis";
    initialPassword = "admin";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvXWZOPOJJDAoF+Sx/ZLoAVu6G/7/MAWoknBgMAzjul dennis@dnsc-mac"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKnmuxDkpDIku5t1Tykz21u78xoQ7LJR8JEcfth32LGu dennis@dnsc-work"
    ];
  };

  # Home Manager Setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      dennis = import ../../home/server.nix;
    };
  };

  # Enable new Nix CLI and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install system wide packages
  environment.systemPackages = with pkgs; [
    git
    btop
    neovim
    wget
  ];

  # Programs
  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  # SSH
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = false;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = false;
  };

  # Tailscale
  services.tailscale.enable = true;

  # Vaultwarden
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets."vaultwarden/env".path;
  };

  # Uptime Kuma
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "9000";
    };
  };

  # Homepage
  services.homepage-dashboard = {
    enable = true;
    listenPort = 9001; 
    services = [
      {
        "VPS" = [
          {
            "Vaultwarden" = {
              href = "https://vault.dnsc.io";
              icon = "vaultwarden.png";
            };
          }
          {
            "Uptime Kuma" = {
              href = "https://uptime.dnsc.io";
              icon = "uptime-kuma.png";
            };
          }
        ];
      }
    ];
  };

  # Caddy
  services.caddy = {
    enable = true;
    virtualHosts."www.dnsc.io".extraConfig = ''
      redir https://dnsc.io{uri}
    '';
    virtualHosts."dnsc.io".extraConfig = ''
      encode gzip
      file_server

      root * /var/www/homepage
    '';
    virtualHosts."slides.dnsc.io".extraConfig = ''
      encode gzip
      file_server

      root * /var/www/slides
    '';
    virtualHosts."vault.dnsc.io".extraConfig = ''
      reverse_proxy localhost:8222
    '';
    virtualHosts."uptime.dnsc.io".extraConfig = ''
      reverse_proxy localhost:9000
    '';
    virtualHosts."home.dnsc.io".extraConfig = ''
      reverse_proxy localhost:9001
    '';
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
  system.stateVersion = "23.11";
}

