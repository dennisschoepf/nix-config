{
  programs.git = {
    enable = true;
    userName = "Dennis Schoepf";
    userEmail = "me@dnsc.io";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      core = {
        ignorecase = "false";
      };

      pull = {
        rebase = false;
      };

      push = {
        autoSetupRemote = true;
      };
    };
  };
}
