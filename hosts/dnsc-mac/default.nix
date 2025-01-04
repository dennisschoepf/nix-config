{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  # Setting the user
  networking.hostName = "dnsc-mac";
  networking.computerName = "dnsc-mac";
  system.defaults.smb.NetBIOSName = "dnsc-mac";

  users.users."dennis"= {
    home = "/Users/dennis";
    description = username;
  };

  nix.settings.trusted-users = [ username ];

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
  
  # Homebrew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "aria2"  # download tool
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      # "google-chrome"
    ];
  };

  # Programgs
  programs.fish.enable = true;

  # System settings
  system = {
    stateVersion = 5;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;  # show 24 hour clock
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Home Manager Setup
  # Home Manager Setup
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      dennis = import ../../home/server;
    };
  };

  # Nix settings
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
}
