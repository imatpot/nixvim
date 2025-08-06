# ⅰnt ⅿain() { рrintf ("Ηello troll!\n"); }
{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config false "trolls" {
  extraPlugins = with pkgs.vimPlugins; [
    vim-troll-stopper
  ];

  highlightOverride.TrollStopper = {
    fg = "NONE";
    bg = "NONE";
  };

  # TODO: only apply highlight to normal buffers

  # autoCmd = [
  #   {
  #     event = [
  #       "BufEnter"
  #       "BufWinEnter"
  #       "WinEnter"
  #       "FileType"
  #       "BufReadPost"
  #     ];
  #     callback =
  #       lib.nixvim.mkRaw
  #       # lua
  #       ''
  #         function()
  #           vim.schedule(function()
  #             if vim.bo.buftype == "" then
  #               local buffer = vim.api.nvim_get_current_buf()
  #               local window = vim.api.nvim_get_current_win()
  #
  #               if not vim.b.troll_stopper_ns then
  #                 vim.b.troll_stopper_ns = vim.api.nvim_create_namespace("TrollStopperNS" .. buffer)
  #                 vim.api.nvim_set_hl(vim.b.troll_stopper_ns, "TrollStopper", { link = "Error", default = true })
  #               end
  #
  #               vim.api.nvim_win_set_hl_ns(window, vim.b.troll_stopper_ns)
  #
  #               if not vim.b.troll_cleanup then
  #                 vim.api.nvim_buf_attach(buffer, false, {
  #                   on_detach = function()
  #                     vim.b.troll_stopper_ns = nil
  #                   end
  #                 })
  #                 vim.b.troll_cleanup = true
  #               end
  #             end
  #           end)
  #         end
  #       '';
  #   }
  # ];
}
