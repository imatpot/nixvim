{
  config,
  lib,
  helpers,
  ...
}: {
  options = {
    modules.themes.vscode.enable = lib.mkEnableOption "vscode";
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
          "@string.special.path.nix" = {
            fg = color "vscOrange";
          };
        };
      };
    };
  };
}
