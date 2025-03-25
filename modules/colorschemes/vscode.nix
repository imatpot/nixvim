{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.modules.mkTheme config "vscode" {
  colorschemes.vscode = {
    enable = true;

    settings = {
      transparent = true;
      underline_links = true;

      group_overrides = let
        # https://github.com/Mofiqul/vscode.nvim/blob/main/lua/vscode/colors.lua
        color = name:
          helpers.mkRaw
          # lua
          "require('vscode.colors').get_colors().${name}";
      in
        {
          CursorLine.bg = color "vscTabCurrent";
          CursorColumn.bg = color "vscTabOther";

          NeoTreeGitIgnored.fg = color "vscGray";
          NeoTreeIndentMarker2 = {
            bg = color "vscNone";
            fg = color "vscGray";
          };

          IndentLine.fg = color "vscCursorDarkDark";
          IndentLineCurrent.fg = color "vscLineNumber";

          "@string.special.path.nix".fg = color "vscOrange";
        }
        // (let
          error = color "vscRed";
          warn = color "vscYellow";
          info = color "vscBlue";
          debug = color "vscPink";
          trace' = color "vscViolet";
        in {
          NotifyERRORBorder.fg = error;
          NotifyERRORIcon.fg = error;
          NotifyERRORTitle.fg = error;

          NotifyWARNBorder.fg = warn;
          NotifyWARNIcon.fg = warn;
          NotifyWARNTitle.fg = warn;

          NotifyINFOBorder.fg = info;
          NotifyINFOIcon.fg = info;
          NotifyINFOTitle.fg = info;

          NotifyDEBUGBorder.fg = debug;
          NotifyDEBUGIcon.fg = debug;
          NotifyDEBUGTitle.fg = debug;

          NotifyTRACEBorder.fg = trace';
          NotifyTRACEIcon.fg = trace';
          NotifyTRACETitle.fg = trace';
        });
    };
  };
}
