{ config, ... }:

{
  xdg.configFile."nvim" = {
    # mkOutOfStoreSymlink needs an absolute path, otherwise it does not work: https://github.com/nix-community/home-manager/issues/676#issuecomment-1595795685
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/nix-config/modules/nvim/config";
  };
}
