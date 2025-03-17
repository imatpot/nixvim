{...}: {
  config = {
    modules = {
      treesitter.enable = true;

      lsp = {
        enable = true;
        all.enable = true;
      };

      formatter = {
        enable = true;
        all.enable = true;
      };

      themes.all.enable = true;
    };
  };
}
