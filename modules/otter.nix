{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "otter" {
  plugins.otter = {
    enable = true;
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
            "---@diagnostic disable: undefined-global, trailing-space"
          ];
        };
      };
    };
  };
}
