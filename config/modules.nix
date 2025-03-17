{...}: {
  config = {
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
  };
}
