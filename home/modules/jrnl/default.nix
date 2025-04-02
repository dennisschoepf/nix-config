{ config, ... }:

{
  xdg.configFile."jrnl.yaml" = {
    # mkOutOfStoreSymlink needs an absolute path, otherwise it does not work: https://github.com/nix-community/home-manager/issues/676#issuecomment-1595795685
    # TODO: At least make the location of the config folder dynamic so that it works on other machines
    source = config.lib.file.mkOutOfStoreSymlink /Users/dennis/dev/nix-config/home/modules/jrnl/jrnl.yaml;
  };
}
