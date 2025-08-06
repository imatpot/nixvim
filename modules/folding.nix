{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "folding" {
  plugins.nvim-ufo = {
    enable = true;

    settings = {
      fold_virt_text_handler =
        lib.nixvim.mkRaw
        # lua
        ''
          -- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
          function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = (' 󱞱 %d '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0

              for _, chunk in ipairs(virtText) do
                  local chunkText = chunk[1]
                  local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  if targetWidth > curWidth + chunkWidth then
                      table.insert(newVirtText, chunk)
                  else
                      chunkText = truncate(chunkText, targetWidth - curWidth)
                      local hlGroup = chunk[2]
                      table.insert(newVirtText, {chunkText, hlGroup})
                      chunkWidth = vim.fn.strdisplaywidth(chunkText)
                      if curWidth + chunkWidth < targetWidth then
                          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                      end
                      break
                  end
                  curWidth = curWidth + chunkWidth
              end

              table.insert(newVirtText, {suffix, 'UfoFoldedEllipsis'})
              return newVirtText
          end
        '';
    };
  };

  opts = {
    foldlevel = 99;
    foldlevelstart = 99;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "=" "za" "Toggle folding")
    (mkKeymap' "<leader>=" "zi" "Toggle all folds")
  ];
}
