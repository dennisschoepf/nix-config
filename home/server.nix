{ config, pkgs, ... }:

{
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    zip
    unzip
    ripgrep
    fzf
    fd
    sd
    bat
    tldr
    fortune
    iotop
    iftop
    just
    mmv-go
    lazygit
    fish
  ];

  imports = [
    ../modules/fish
    ../modules/lazygit
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Dennis Schoepf";
    userEmail = "me@dnsc.io";
    extraConfig = {
      pull = {
        rebase = true;
      };
    };
  };
}
