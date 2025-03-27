{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.modules.mkModule config true "bufferline" {
  plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        diagnostics = "nvim_lsp";
        show_buffer_close_icons = false;
        always_show_bufferline = false;
        style_preset =
          helpers.mkRaw
          # lua
          "require('bufferline').style_preset.no_italic";
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<C-t>" "<CMD>enew<CR>" "New buffer")
    (mkKeymap' "<C-l>" "<CMD>bnext<CR>" "Next buffer")
    (mkKeymap' "<C-H>" "<CMD>bprevious<CR>" "Previous buffer")

    (mkKeymap' "<leader>q" "<CMD>lua CloseBuffer()<CR>" "Close buffer")
    (mkKeymap' "<leader>Q" "<CMD>qa<CR>" "Close all buffers")
    (mkKeymap' "<leader>w" "<CMD>w<CR>" "Write buffer")
    (mkKeymap' "<leader>W" "<CMD>wa<CR>" "Write all buffers")
    (mkKeymap' "<leader>z" "<CMD>w | lua CloseBuffer()<CR>" "Write and close buffer")
    (mkKeymap' "<leader>Z" "<CMD>wqa<CR>" "Write and close all buffers")

    (
      mkKeymap' "<leader><Tab>" (
        "<CMD>"
        + (
          if config.plugins.telescope.enable
          then "Telescope buffers"
          else "ls"
        )
        + "<CR>"
      ) "List buffers"
    )
  ];

  extraConfigLuaPre = builtins.readFile ./buffers.lua;
}
