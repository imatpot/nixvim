{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.modules.mkModule config true "bufferline" {
  plugins.barbar = {
    enable = true;

    settings = {
      animation = false;
      auto_hide = 1;
      insert_At_end = true;
      letters = "asdfghjklqwertzuiopyxcvbnm";
      maximum_padding = 2;
      minimum_padding = 2;

      sidebar_filetypes = {
        "neo-tree" = {
          event = "BufWipeout";
        };
      };

      icons = {
        button = "";
        modified.button = "•";
        inactive.separator.left = "";

        separator = {
          left = "";
          right = "";
          at_end = "";
        };

        diagnostics = {
          "vim.diagnostic.severity.ERROR" = {
            enabled = true;
            icon = " ";
          };
          "vim.diagnostic.severity.WARN" = {
            enabled = true;
            icon = " ";
          };
          "vim.diagnostic.severity.INFO" = {
            enabled = true;
            icon = " ";
          };
          "vim.diagnostic.severity.HINT" = {
            enabled = true;
            icon = " ";
          };
        };
      };
    };
  };

  plugins.bufferline = {
    enable = false;

    settings = {
      options = {
        diagnostics = "nvim_lsp";
        diagnostics_indicator = "BufferDiagnostics";
        show_buffer_close_icons = false;
        always_show_bufferline = false;
        offsets = [
          {
            filetype = "neo-tree";
            text = "";
            text_align = "left";
          }
        ];
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
