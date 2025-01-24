{ config, pkgs, ... }:

{
  home.username = "dennis";
  home.homeDirectory = "/Users/dennis";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
  };

  imports = [
    ./modules/git
    ./modules/fish
    ./modules/wezterm
    ./modules/nvim
  ];

  programs.home-manager.enable = true;
}
