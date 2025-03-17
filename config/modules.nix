{...}: {
  config = {
    modules = {
      treesitter.enable = true;
      which-key.enable = true;
      mini.enable = true;
      neo-tree.enable = true;
      telescope.enable = true;

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
