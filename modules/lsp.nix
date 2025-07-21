{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "lsp" {
  performance.combinePlugins.standalonePlugins = ["lsp"];

  plugins = {
    lsp = {
      enable = true;
      inlayHints = false;
    };

    trouble = {
      enable = true;
      settings = {
        focus = true;
        warn_no_results = false;
      };
    };

    lint = {
      enable = true;

      # FIXME: https://github.com/mfussenegger/nvim-lint/issues/235
      autoCmd.event = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  files."ftplugin/Trouble.lua".opts.wrap = true;

  keymaps = let
    lsp = "lua vim.lsp";
    lspBuffer = "${lsp}.buf";
  in
    with lib.utils.keymaps; [
      (mkKeymap' "." "<CMD>${lspBuffer}.hover()<CR>" "Hover")
      (mkKeymap' "<leader>." "<C-.>" "Code actions")
      (mkKeymap ["n"] "<C-.>" "<CMD>${lspBuffer}.code_action()<CR>" "Code actions")
      (mkKeymap ["x"] "<C-.>" "<CMD>lua vim.lsp.buf.range_code_action()<CR>" "Code actions")

      (mkKeymap ["n"] "<leader>r" "<CMD>${lspBuffer}.rename()<CR>" "Rename")
      (mkKeymap' "<leader>H" "<CMD>${lsp}.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>" "Toggle inlay hints")
      (mkKeymap' "<leader>D" "<CMD>Trouble diagnostics toggle<CR>" "Toggle diagnostics")

      (mkKeymap ["n"] "gd" "<CMD>lua vim.lsp.buf.definition()<CR>" "Go to definition")
      (mkKeymap ["n"] "gD" "<CMD>lua vim.lsp.buf.declaration()<CR>" "Go to declaration")
      (mkKeymap ["n"] "gr" "<CMD>lua vim.lsp.buf.references()<CR>" "Go to references")
    ];

  extraConfigLua =
    # lua
    ''
      vim.lsp.set_log_level("off")
    '';
}
