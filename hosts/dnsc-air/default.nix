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
    ../../home/modules/aerospace
  ];

  # Setting the user
  networking.hostName = "dnsc-air";
  networking.computerName = "dnsc-air";

  users.users."dennis"= {
    home = "/Users/dennis";
    description = "Dennis Schoepf";
  };

  nix.settings.trusted-users = [ "dennis" ];

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
    aider-chat
    fortune
    neofetch
  ];
  
  # Homebrew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "lazygit"
      "ffmpeg"
      "tree-sitter"
      "yt-dlp"
      "zoxide"
      "pinentry"
      "pinentry-mac"
      "shellcheck"
      "sqlite"
      "tinymist"
      "typst"
      "rsync"
      "fnm"
      "imagemagick"
    ];

    casks = [
      "zen-browser"
      "font-victor-mono"
      "font-victor-mono-nerd-font"
      "mullvadvpn"
      "vlc"
      "alfred"
      "wezterm"
      "arc"
      "hiddenbar"
      "syncthing"
      "eurkey"
      "karabiner-elements"
      "vial"
      "wezterm"
    ];
  };

  # Shells
  environment.shells = [ pkgs.fish ];

  # System settings
  system = {
    stateVersion = 5;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = "dnsc-air";

      dock = {
        autohide = true;
        autohide-delay = 0.01;
        autohide-time-modifier = 0.01;
        expose-group-apps = true;
        launchanim = false;
        minimize-to-application = true;
        orientation = "left";
        show-recents = false;
        persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/WezTerm.app"
          "/Applications/Photomator.app"
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
  security.pam.enableSudoTouchIdAuth = true;

  # Home Manager Setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    users = {
      dennis = import ../../home/darwin.nix;
    };
  };

  # Nix settings
  # Enable new Nix CLI and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 1w";
  };
}
