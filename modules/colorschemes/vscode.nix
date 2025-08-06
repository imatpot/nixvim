{
  config,
  lib,
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
          lib.nixvim.mkRaw
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
            StatusLine.bg = "none";

            CursorLine.bg = color "vscBack";
            CursorColumn.link = "CursorLine";

            BlinkCmpMenu.bg = "none";
            BlinkCmpMenuBorder.bg = "none";
            BlinkCmpDoc.bg = "none";
            BlinkCmpDocBorder.bg = "none";
            BlinkCmpDocSeparator.bg = "none";

            TreesitterContext.bg = "#101010";

            NeoTreeFileIcon.link = "MiniIconsGrey";
            NeoTreeIndentMarker2 = {
              bg = "none";
              fg = color "vscGray";
            };

            NeoTreeGitModified.fg = color "vscGitModified";
            NeoTreeGitIgnored.fg = color "vscGray";
            NeoTreeGitAdded.fg = color "vscGitAdded";
            NeoTreeGitDeleted.fg = color "vscGitDeleted";
            NeoTreeGitRenamed.fg = color "vscBlueGreen";
            NeoTreeModified.link = "NeoTreeGitModified";
            NeoTreeGitUnstaged.link = "NeoTreeGitModified";
            NeoTreeGitStaged.link = "NeoTreeGitAdded";
            NeoTreeGitUntracked.link = "NeoTreeGitAdded";

            NeoTreeGitConflict = {
              fg = color "vscPink";
              italic = true;
            };

            VirtColumn.fg = color "vscCursorDarkDark";
            IndentLine.fg = color "vscCursorDarkDark";
            IndentLineCurrent.fg = color "vscLineNumber";

            SnacksDashboardIcon.fg = color "vscLightBlue";
            SnacksDashboardDesc.fg = color "vscFront";
            SnacksDashboardKey.fg = color "vscLineNumber";

            "@string.special.path.nix".fg = color "vscOrange";
            "@constructor.typescript".fg = "none";

            BufferTabpageFill.bg = "none";
            TabLineFill.bg = "none";

            BufferInactiveMod = BufferInactive // {italic = true;};
            BufferInactiveERROR = BufferInactive // {fg = color "vscRed";};
            BufferInactiveWARN = BufferInactive // {fg = color "vscYellowOrange";};
            BufferInactiveINFO = BufferInactive // {fg = color "vscBlue";};
            BufferInactiveHINT = BufferInactive // {fg = color "vscBlueGreen";};
            BufferInactive = {
              bg = "none";
              fg = color "vscLeftLight";
            };

            BufferCurrentMod = BufferCurrent // {italic = true;};
            BufferCurrentERROR = BufferCurrent // {fg = color "vscRed";};
            BufferCurrentWARN = BufferCurrent // {fg = color "vscYellowOrange";};
            BufferCurrentINFO = BufferCurrent // {fg = color "vscBlue";};
            BufferCurrentHINT = BufferCurrent // {fg = color "vscBlueGreen";};
            BufferCurrent = {
              bg = color "vscBack";
              fg = color "vscFront";
            };

            BufferVisibleMod = BufferVisible // {italic = true;};
            BufferVisibleERROR = BufferVisible // {fg = color "vscRed";};
            BufferVisibleWARN = BufferVisible // {fg = color "vscYellowOrange";};
            BufferVisibleINFO = BufferVisible // {fg = color "vscBlue";};
            BufferVisibleHINT = BufferVisible // {fg = color "vscBlueGreen";};
            BufferVisible = {
              bg = color "vscBack";
              fg = color "vscFront";
            };

            MiniIconsOrange.fg = "#FC6D27";
            MiniIconsBlue.fg = color "vscBlue";
            MiniIconsAzure.fg = color "vscMediumBlue";

            PackageInfoUpToDateVersion.link = "Comment";
            PackageInfoOutdatedVersion.link = "WarningMsg";
            PackageInfoInErrorVersion.link = "ErrorMsg";

            CopilotChatHeader.fg = color "vscSuggestion";
            CopilotChatSeparator.fg = color "vscContext";

            CsvViewDelimiter.link = "NonText";
            DropBarIconUISeparator.link = "NonText";
            WinBar.bold = false;

            UfoFoldedEllipsis.fg = "#607DB8";
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
