{lib, ...}: {
  imports = lib.utils.umport {path = ./modules;};
  enableMan = false;

  modules = {
    plugins = {
      lsp = {
        enable = true;
        all.enable = true;
      };

      treesitter.enable = true;
    };

    themes.all.enable = true;
  };
}
