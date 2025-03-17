{
  config,
  lib,
  ...
}: {
  options = {
    modules.plugins.lsp.enable = lib.mkEnableOption "lsp plugin";
    modules.plugins.lsp.all.enable = lib.mkEnableOption "all configured lsp servers";
  };

  config = lib.mkIf config.modules.plugins.lsp.enable {
    # lower semantic token priorities to <100, so treesitter takes priority
    extraConfigLuaPost = ''
      vim.highlight.priorities.semantic_tokens = 95
    '';

    plugins.lsp = {
      enable = true;
      inlayHints = true;
    };
  };
}
