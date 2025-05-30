{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "dnsc-server" = {
        hostname = "100.103.199.4";
        user = "dennis";
        identityFile = "/Users/dennis/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "dnsc-server-i" = {
        hostname = "192.168.178.69";
        user = "dennis";
        identityFile = "/Users/dennis/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "dnsc-vps-sm" = {
        hostname = "100.65.82.77";
        user = "dennis";
        identityFile = "/Users/dennis/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
