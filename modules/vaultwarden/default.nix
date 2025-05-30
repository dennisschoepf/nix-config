{
  config, ...
}: {
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets."vaultwarden/env".path;
  };
}
