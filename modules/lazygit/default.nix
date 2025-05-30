{ config, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        theme = {
          selectedLineBgColor = [ "#332d41" ];
          searchingActiveBorderColor = [ "#31748f" "bold" ];
          optionsTextColor = [ "#ebbcba" ];
          inactiveBorderColor = [ "#6e6a86" ];
          defaultFgColor = [ "#e0def4" ];
          cherryPickedCommitFgColor = [ "#ebbcba" ];
          cherryPickedCommitBgColor = [ "#e0def4" ];
          activeBorderColor = [ "#31748f" "bold" ];
          unstagedChangesColor = [ "#eb6f92" ];
        };
      };
    };
  };
}
