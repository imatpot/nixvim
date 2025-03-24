{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "lsp" {
  plugins.lsp = {
    enable = true;
    inlayHints = false;
  };

  keymaps = let
    lsp = "lua vim.lsp";
    lspBuffer = "${lsp}.buf";
  in
    with lib.utils.keymaps; [
      (mkKeymap ["n"] "<leader>." "<CMD>${lspBuffer}.code_action()<CR>" "Code action")
      (mkKeymap ["x"] "<leader>." "<CMD>lua vim.lsp.buf.range_code_action()<CR>" "Code actions")
      (mkKeymap ["n"] "<leader>r" "<CMD>${lspBuffer}.rename()<CR>" "Rename")
      (mkKeymap' "<leader>h" "<CMD>${lsp}.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>" "Toggle inlay hints")

      (mkKeymap ["n"] "gd" "<CMD>lua vim.lsp.buf.definition()<CR>" "Go to definition")
      (mkKeymap ["n"] "gD" "<CMD>lua vim.lsp.buf.declaration()<CR>" "Go to declaration")
      (mkKeymap ["n"] "gr" "<CMD>lua vim.lsp.buf.references()<CR>" "Go to references")
    ];
}
