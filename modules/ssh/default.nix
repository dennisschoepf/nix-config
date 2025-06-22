{ config, ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "dnsc-server" = {
        hostname = "100.103.199.4";
        user = "dennis";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "dnsc-server-i" = {
        hostname = "192.168.178.69";
        user = "dennis";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "dnsc-vps-sm" = {
        hostname = "100.65.82.77";
        user = "dennis";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "dnsc-storage" = {
        hostname = "u295965.your-storagebox.de";
        user = "u295965";
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        identitiesOnly = true;
        port = 23;
      };
    };
  };
}
