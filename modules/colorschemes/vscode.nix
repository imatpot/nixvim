{
  config,
  lib,
  helpers,
  ...
}: {
  options = {
    modules.themes.vscode.enable = lib.utils.mkDefaultEnableOption true "vscode";
  };

  config = lib.mkIf (config.modules.themes.vscode.enable || config.modules.themes.all.enable) {
    colorschemes.vscode = {
      enable = true;

      settings = {
        transparent = true;
        underline_links = true;

        group_overrides = let
          color = name: helpers.mkRaw "require('vscode.colors').get_colors().${name}";
        in {
          CursorLine = {
            bg = color "vscTabCurrent";
          };

          CursorColumn = {
            bg = color "vscTabOther";
          };

          NeoTreeGitIgnored = {
            fg = color "vscGray";
          };

          NeoTreeIndentMarker2 = {
            bg = color "vscNone";
            fg = color "vscGray";
          };

          IndentLine = {
            fg = color "vscCursorDarkDark";
          };

          IndentLineCurrent = {
            fg = color "vscLineNumber";
          };

          "@string.special.path.nix" = {
            fg = color "vscOrange";
          };
        };
      };
    };
  };
}
