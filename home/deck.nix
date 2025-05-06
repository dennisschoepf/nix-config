{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  
  nixpkgs = {
  	config = {
    	allowUnfree = true;
    	allowUnfreePredicate = (_: true);
    };
  };

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    git
    neovim
    neofetch
    zip
    unzip
    ripgrep
    fzf
    just
    lazygit
  ];

  xdg.enable = true;

  imports = [
    ./modules/git
    ./modules/fish
    ./modules/atuin
    ./modules/nvim
    ./modules/lazygit
  ];

  programs.home-manager.enable = true;
}
