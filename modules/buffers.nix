{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.modules.mkSimple config true "bufferline" {
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
    (mkKeymap' "<leader>Z" "<CMDwqa<CR>" "Write and close all buffers")

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

  extraConfigLuaPre =
    # lua
    ''
      function CountBuffersByType(loaded_only)
        loaded_only = loaded_only == nil and true or loaded_only
        local buffer_types = vim.api.nvim_list_bufs()
        local counts = {}

        for _, buf in ipairs(buffer_types) do
          if not loaded_only or vim.api.nvim_buf_is_loaded(buf) then
            local buf_type = vim.api.nvim_buf_get_option(buf, 'buftype')
            buf_type = buf_type ~= "" and buf_type or "normal"
            counts[buf_type] = (counts[buf_type] or 0) + 1
          end
        end

        return counts
      end

      function CloseBuffer()
        local counts = CountBuffersByType()

        if counts.normal <= 1 then
          vim.api.nvim_exec(":q", true)
        else
          vim.api.nvim_exec(":bprevious | bdelete #", true)
        end
      end
    '';
}
