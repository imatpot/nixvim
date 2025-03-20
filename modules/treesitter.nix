{
  config,
  lib,
  ...
}: {
  options = {
    modules.treesitter.enable = lib.utils.mkDefaultEnableOption true "treesitter";
  };

  config = lib.mkIf config.modules.treesitter.enable {
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
  };
}
