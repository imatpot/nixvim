{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "lsp" true {
  plugins.lsp = {
    enable = true;
    inlayHints = false;
  };

  keymaps = let
    lsp = "lua vim.lsp";
    lspBuffer = "${lsp}.buf";
  in [
    {
      key = "<C-.>";
      action = "<CMD>${lspBuffer}.code_action()<CR>";
      mode = ["n" "i"];
      options.desc = "Code action";
    }
    {
      key = "<C-.>";
      action = "<CMD>lua vim.lsp.buf.range_code_action()<CR>";
      mode = ["x"];
      options.desc = "Code actions";
    }
    {
      key = "<C-r>";
      action = "<CMD>${lspBuffer}.rename()<CR>";
      mode = ["n" "i"];
      options.desc = "Rename";
    }
    {
      key = "<C-h>";
      action = "<CMD>${lsp}.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      options.desc = "Toggle inlay hints";
    }
    {
      key = "gd";
      action = "<CMD>lua vim.lsp.buf.definition()<CR>";
      mode = ["n"];
      options.desc = "Go to definition";
    }
    {
      key = "gD";
      action = "<CMD>lua vim.lsp.buf.declaration()<CR>";
      mode = ["n"];
      options.desc = "Go to declaration";
    }
    {
      key = "gr";
      action = "<CMD>lua vim.lsp.buf.references()<CR>";
      mode = ["n"];
      options.desc = "Go to references";
    }
  ];
}
