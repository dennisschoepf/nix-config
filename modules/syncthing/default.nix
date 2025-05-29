{
  services.syncthing = {
    enable = true;
    group = "users";
    guiAddress = "0.0.0.0:8384";
    user = "dennis";
    dataDir = "/home/dennis/sync";
    configDir = "/home/dennis/sync/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "dnsc-pixel" = { id = "FD4XYVI-UZCBEXZ-OATLR3Y-7ZZPQOA-MFWP3Q7-OFNZY33-XH4TJAF-KVHW2AI"; };
        "dnsc-air" = { id = "RYFO5XN-RRZZQI3-4W5DPHO-C7OKL5N-ZUQUBEI-ZKSWUHM-2BMTFRY-MDC7MA3"; };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}

