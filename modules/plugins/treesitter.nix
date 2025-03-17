{
  config,
  lib,
  ...
}: {
  options = {
    modules.plugins.treesitter.enable = lib.mkEnableOption "treesitter";
  };

  config = lib.mkIf config.modules.plugins.treesitter.enable {
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };
  };
}
