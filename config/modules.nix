{...}: {
  config = {
    modules = {
      treesitter.enable = true;
      which-key.enable = true;
      mini.enable = true;
      snacks.enable = true;
      neo-tree.enable = true;
      telescope.enable = true;
      indent-lines.enable = true;
      completions.enable = true;
      completions.copilot.enable = true;

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
