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
      italic_comments = true;

      group_overrides = let
        # https://github.com/Mofiqul/vscode.nvim/blob/main/lua/vscode/colors.lua
        color = name:
          helpers.mkRaw
          # lua
          "require('vscode.colors').get_colors().${name}";
      in
        lib.mkMerge [
          rec {
            WarningMsg = {
              fg = color "vscYellow";
              italic = false;
              bold = false;
            };

            ErrorMsg = {
              fg = color "vscRed";
              italic = false;
              bold = false;
            };

            "@comment".link = "Comment";
            SpecialComment.link = "Comment";

            DiagnosticWarn.fg = color "vscYellowOrange";
            DiagnosticHint.fg = color "vscBlueGreen";
            StatusLine.bg = color "vscNone";

            CursorLine.bg = color "vscBack";
            CursorColumn.link = "CursorLine";

            NeoTreeFileIcon.link = "MiniIconsGrey";
            NeoTreeGitIgnored.fg = color "vscGray";
            NeoTreeIndentMarker2 = {
              bg = color "vscNone";
              fg = color "vscGray";
            };

            VirtColumn.fg = color "vscCursorDarkDark";
            IndentLine.fg = color "vscCursorDarkDark";
            IndentLineCurrent.fg = color "vscLineNumber";

            SnacksDashboardIcon.fg = color "vscLightBlue";
            SnacksDashboardDesc.fg = color "vscFront";
            SnacksDashboardKey.fg = color "vscLineNumber";

            "@string.special.path.nix".fg = color "vscOrange";

            BufferTabpageFill.bg = color "vscNone";
            TabLineFill.bg = color "vscNone";

            BufferInactiveMod = BufferInactive // {italic = true;};
            BufferInactiveERROR = BufferInactive // {fg = color "vscRed";};
            BufferInactiveWARN = BufferInactive // {fg = color "vscYellow";};
            BufferInactiveINFO = BufferInactive // {fg = color "vscBlue";};
            BufferInactiveHINT = BufferInactive // {fg = color "vscBlueGreen";};
            BufferInactive = {
              bg = color "vscNone";
              fg = color "vscLeftLight";
            };

            BufferCurrentMod = BufferCurrent // {italic = true;};
            BufferCurrentERROR = BufferCurrent // {fg = color "vscRed";};
            BufferCurrentWARN = BufferCurrent // {fg = color "vscYellow";};
            BufferCurrentINFO = BufferCurrent // {fg = color "vscBlue";};
            BufferCurrentHINT = BufferCurrent // {fg = color "vscBlueGreen";};
            BufferCurrent = {
              bg = color "vscTabOther";
              fg = color "vscFront";
            };

            MiniIconsOrange.fg = "#FC6D27";
            MiniIconsBlue.fg = color "vscBlue";
            MiniIconsAzure.fg = color "vscMediumBlue";

            PackageInfoUpToDateVersion.link = "Comment";
            PackageInfoOutdatedVersion.link = "WarningMsg";
            PackageInfoInErrorVersion.link = "ErrorMsg";
          }
          (
            let
              mkCategory = name: colorName: {
                "Notify${name}Border".fg = color colorName;
                "Notify${name}Icon".fg = color colorName;
                "Notify${name}Title".fg = color colorName;
              };
            in
              lib.mkMerge [
                (mkCategory "ERROR" "vscRed")
                (mkCategory "WARN" "vscYellow")
                (mkCategory "INFO" "vscBlue")
                (mkCategory "DEBUG" "vscPink")
                (mkCategory "TRACE" "vscViolet")
              ]
          )
        ];
    };
  };
}
