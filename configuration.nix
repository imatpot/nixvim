{
  pkgs,
  utils,
  ...
}: {
  imports = utils.umport {path = ./modules;};

  enableMan = false;

  extraPlugins = with pkgs.vimPlugins; [];

  modules = {
    lsp.enable = true;
    lsp.all.enable = true;
  };
}
