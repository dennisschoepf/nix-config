{ config, pkgs, ... }:

{
  home.username = "dennis";
  home.stateVersion = "24.11";
  home.homeDirectory = "/Users/dennis";
  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"; 
    ANDROID_HOME = "$HOME/Library/Android/sdk";
  };

  xdg.enable = true;

  imports = [
    ../modules/git
    ../modules/fish/work.nix
    ../modules/atuin
    ../modules/wezterm
    ../modules/nvim
    ../modules/lazygit
  ];

  programs.home-manager.enable = true;
}
