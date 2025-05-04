{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "treesitter" {
  extraConfigLuaPost =
    # lua
    ''
      vim.hl.priorities.semantic_tokens = 95
    '';

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

    treesitter-textobjects.enable = true;
  };
}
