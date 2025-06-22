{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/aerospace/work.nix
  ];

  # Setting the user
  networking.hostName = "dnsc-work";
  networking.computerName = "dnsc-work";

  users.users."dennis"= {
    home = "/Users/dennis";
    description = "Dennis Schoepf";
  };

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
    tailwindcss-language-server
    lua-language-server
    prettierd
    eslint_d
    atuin
    nil
    nurl
    shellcheck
    lazygit
    ffmpeg
    tree-sitter
    zoxide
    sqlite
    fnm
    imagemagick
    # rsync
  ];
  
  # Homebrew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
      Bitwarden = 1352778147;
      # XCode = 497799835;
    };

    brews = [
      "mas"
      "watchman"
      "pnpm"
      "pkg-config"
      "cairo"
      "pango"
      "libpng"
      "jpeg"
      "giflib"
      "librsvg"
      "pixman"
      "python-setuptools"
      "gmp"
      "rbenv"
    ];

    casks = [
      "arc"
      "microsoft-teams"
      # "tailscale"
      "font-victor-mono"
      "font-victor-mono-nerd-font"
      "vlc"
      "alfred"
      "wezterm"
      "hiddenbar"
      "syncthing"
      "eurkey"
      "karabiner-elements"
      "wezterm"
      "1password"
      "1password-cli"
      "android-studio"
      "zulu@17"
      "postman"
      "docker"
    ];
  };

  # Shells
  environment.shells = [ pkgs.fish ];

  # System settings
  system = {
    primaryUser = "dennis";
    stateVersion = 5;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = "dnsc-work";

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
          "/Applications/Arc.app"
          "/Applications/WezTerm.app"
          "/Applications/Microsoft Teams.app"
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
        LoginwindowText = "\\U03bb dnsc-work (powered by Nix)";
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
      dennis = import ../../home/darwin-work.nix;
    };
  };

  # Nix settings
  # Use determinate systems
  nix.enable = false;
}
