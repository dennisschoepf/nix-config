{
  services.syncthing = {
    enable = true;
    group = "users";
    guiAddress = "0.0.0.0:8384";
    user = "dennis";
    dataDir = "/home/dennis/sync";
    # configDir = "/home/dennis/sync/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "dnsc-air" = { id = "RYFO5XN-RRZZQI3-4W5DPHO-C7OKL5N-ZUQUBEI-ZKSWUHM-2BMTFRY-MDC7MA3"; };
        "dnsc-phone" = { id = "NGHODAF-W646NPR-R5IEL2R-QLULKB6-I4APGMB-5PIM6B6-5HZCLAV-HRTSEQI"; };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}

