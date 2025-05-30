{
  power.ups = {
    enable = true;
  
    ups."eaton-ups" = {
      driver = "usbhid-ups";
      port = "auto";
    };
  
    users.upsmon = {
      passwordFile = "/etc/upsmon.passwd";
      upsmon = "primary";
    };
  
    upsmon.monitor."eaton-ups".user = "upsmon";
  };
}

