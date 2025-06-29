{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/aerospace
  ];

  # Setting the user
  networking.hostName = "dnsc-air";
  networking.computerName = "dnsc-air";

  users.users."dennis" = {
    home = "/Users/dennis";
    description = "Dennis Schoepf";
  };

  nix.settings.trusted-users = [ "dennis" ];

  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    btop
    fish
    ripgrep
    fzf
    fd
    sd
    bat
    neovim
    just
    tldr
    fortune
    neofetch
    stylua
    typescript-language-server
    vscode-langservers-extracted
    astro-language-server
    tailwindcss-language-server
    lua-language-server
    prettierd
    eslint_d
    atuin
    nil
    shellcheck
    lazygit
    ffmpeg
    yt-dlp
    zoxide
    sqlite
    tree-sitter
    rsync
    fnm
    imagemagick
    restic
  ];

  # Homebrew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    masApps = {
      Bitwarden = 1352778147;
      "Kagi for Safari" = 1622835804;
      "Wipr 2" = 1662217862;
      "Yesterday For Old Reddit" = 1603279883;
    };

    brews = [
      "mas"
    ];

    casks = [
      "chromium"
      "font-victor-mono"
      "font-victor-mono-nerd-font"
      "vlc"
      "wezterm"
      "hiddenbar"
      "syncthing"
      "eurkey"
      "karabiner-elements"
      "wezterm"
      "cyberduck"
      "caffeine"
      "tailscale"
      "raycast"
      "spotify"
    ];
  };

  # Shells
  environment.shells = [ pkgs.fish ];

  # System settings
  system = {
    primaryUser = "dennis";
    stateVersion = 5;
    activationScripts.postActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = "dnsc-air";

      NSGlobalDomain."com.apple.swipescrolldirection" = false;

      dock = {
        autohide = true;
        autohide-delay = 0.01;
        autohide-time-modifier = 0.01;
        expose-group-apps = true;
        launchanim = false;
        minimize-to-application = true;
        orientation = "right";
        show-recents = false;
        persistent-apps = [
          "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
          "/Applications/WezTerm.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/System Settings.app/"
        ];
        persistent-others = [
          "/Users/dennis/Downloads"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      loginwindow = {
        LoginwindowText = "\\U03bb dnsc-air (powered by Nix)";
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0;
      };

      screencapture = {
        location = "/Users/dennis/Downloads";
        target = "file";
      };

      spaces.spans-displays = false;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Home Manager Setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users = {
      dennis = import ../../home/darwin.nix;
    };
  };

  # Nix settings
  # Enable new Nix CLI and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.package = pkgs.nix;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 1w";
  };
}
