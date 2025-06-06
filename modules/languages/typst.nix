{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "typst" {
  plugins = {
    lsp.servers.tinymist.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.typst = ["typstyle"];
      formatters.typstyle.command = lib.getExe pkgs.typstyle;
    };

    typst-preview.enable = true;
  };

  files."ftplugin/typst.lua" = {
    opts = {
      wrap = true;
    };

    keymaps = with lib.utils.keymaps; [
      (mkBufferKeymap' "<localleader>f" "<CMD>TypstPreviewFollowCursorToggle<CR>" "Toggle cursor following")
      (mkBufferKeymap' "<localleader>p" "<CMD>TypstPreviewToggle<CR>" "Toggle preview")
      (mkBufferKeymap' "<localleader>q" "<CMD>TypstPreviewStop<CR>" "Stop review")
      (mkBufferKeymap' "<localleader>u" "<CMD>TypstPreviewUpdate<CR>" "Update preview")
    ];
  };
}
