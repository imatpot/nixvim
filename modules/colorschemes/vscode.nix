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
        lib.mkMerge [
          {
            DiagnosticWarn.fg = color "vscYellowOrange";

            CursorLine.bg = color "vscTabCurrent";
            CursorColumn.bg = color "vscTabOther";

            NeoTreeGitIgnored.fg = color "vscGray";
            NeoTreeIndentMarker2 = {
              bg = color "vscNone";
              fg = color "vscGray";
            };

            IndentLine.fg = color "vscCursorDarkDark";
            IndentLineCurrent.fg = color "vscLineNumber";

            SnacksDashboardIcon.fg = color "vscLightBlue";
            SnacksDashboardDesc.fg = color "vscFront";
            SnacksDashboardKey.fg = color "vscLineNumber";

            "@string.special.path.nix".fg = color "vscOrange";
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
          (
            let
              mkHi = category: normal: {
                "${category}".fg = color normal;
              };
              mkHi' = category: normal: selected: {
                "${category}Visible".fg = color normal;
                "${category}Selected".fg = color selected;
              };
              mkFullHi = category: normal: selected:
                mkHi category normal
                // mkFullHi category normal selected;
            in
              lib.mkMerge []
          )
        ];
    };
  };

  autoCmd = [
    {
      event = "VimEnter";
      callback =
        helpers.mkRaw
        # lua
        ''
          function()
            vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = nil })
          end
        '';
    }
  ];
}
