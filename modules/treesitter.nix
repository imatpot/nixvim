{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "treesitter" true {
  extraConfigLuaPost = ''
    vim.highlight.priorities.semantic_tokens = 95
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
