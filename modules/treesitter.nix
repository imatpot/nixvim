{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "treesitter" {
  performance.combinePlugins.standalonePlugins = ["nvim-treesitter"];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };

    treesitter-context = {
      enable = true;
      settings = {
        mode = "topline";
      };
    };

    treesitter-textobjects.enable = true;
  };

  extraConfigLuaPost =
    # lua
    ''
      vim.hl.priorities.semantic_tokens = 95
    '';
}
