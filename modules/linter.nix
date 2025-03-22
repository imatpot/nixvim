{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "linter" {
  plugins.lint = {
    enable = true;

    # FIXME: https://github.com/mfussenegger/nvim-lint/issues/235
    autoCmd.event = [
      "BufReadPost"
      "BufWritePost"
      "InsertLeave"
    ];
  };
}
