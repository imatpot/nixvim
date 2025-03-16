{
  pkgs,
  lib,
  ...
}: {
  imports = lib.utils.umport {path = ./modules;};

  enableMan = false;

  extraPlugins = with pkgs.vimPlugins; [];

  modules = {
    lsp.enable = true;
    lsp.all.enable = true;
  };
}
