{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "bufferline" {
  plugins.barbar = {
    enable = true;

    settings = {
      animation = false;
      auto_hide = 1;
      insert_At_end = true;
      letters = "asdfghjklqwertzuiopyxcvbnm";
      maximum_padding = 2;
      minimum_padding = 2;

      sidebar_filetypes.neo-tree = true;

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

  keymaps = with lib.utils.keymaps; [
    # i never know which one it is, so let's have both!
    (mkKeymap' "<leader>t" "<CMD>enew<CR>" "New buffer")
    (mkKeymap' "<leader>n" "<CMD>enew<CR>" "New buffer")

    (mkKeymap' "<C-l>" "<CMD>BufferNext<CR>" "Next buffer")
    (mkKeymap' "<C-h>" "<CMD>BufferPrevious<CR>" "Previous buffer")

    (mkKeymap' "<C-S-L>" "<CMD>BufferMoveNext<CR>" "Move buffer right")
    (mkKeymap' "<C-S-H>" "<CMD>BufferMovePrevious<CR>" "Move buffer left")

    (mkKeymap' "<leader><up>" "<CMD>BufferPick<CR>" "Pick buffer")
    (mkKeymap' "<leader>P" "<CMD>BufferPin<CR>" "Pin buffer")
    (mkKeymap' "<leader>T" "<CMD>BufferRestore<CR>" "Restore buffer")

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
