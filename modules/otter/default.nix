{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "otter" {
  plugins.otter = {
    enable = true;
    lazyLoad.settings.event = ["BufNewFile" "BufRead"];

    settings = {
      handle_leading_whitespace = true;

      lsp.diagnostic_update_events = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];

      buffers = {
        preambles = {
          lua = [
            # lua
            "---@diagnostic disable: trailing-space, undefined-global, unreachable-code, unused-local"
          ];
        };
      };
    };
  };

  extraConfigLuaPre = builtins.readFile ./otter.lua;
}
