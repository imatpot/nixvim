{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "icons" {
  plugins = {
    # web-devicons.enable = true;

    mini = {
      enable = true;
      mockDevIcons = true;

      modules.icons = {
        enabled = true;

        default = {
          file = {
            glyph = "";
            hl = "MiniIconsGrey";
          };
        };

        extension = {
          json.glyph = "";
          yaml.glyph = "";
          yml.glyph = "";
          typ.glyph = "";
          dart.glyph = ""; # let's be real, that's the only reason people use dart
          gradle.glyph = "";
          properties.glyph = "";

          temp.glyph = "";
          tmp.glyph = "";

          kt.hl = "MiniIconsPurple";
          scss.hl = "MiniIconsPurple";
          "spec.ts".hl = "MiniIconsCyan";
          "routes.ts".hl = "MiniIconsGreen";
          "module.ts".hl = "MiniIconsRed";

          "test.dart".hl = "MiniIconsCyan";

          ico = {
            glyph = "";
            hl = "MiniIconsYellow";
          };

          arb = {
            glyph = "";
            hl = "MiniIconsYellow";
          };

          lock = {
            glyph = "";
            hl = "MiniIconsYellow";
          };

          "lock.json" = {
            glyph = "";
            hl = "MiniIconsYellow";
          };

          "lock.yaml" = {
            glyph = "";
            hl = "MiniIconsYellow";
          };

          "lock.yml" = {
            glyph = "";
            hl = "MiniIconsYellow";
          };
        };

        file = {
          "README.md".hl = "MiniIconsBlue";

          ".gitignore".hl = "MiniIconsOrange";
          ".gitkeep".hl = "MiniIconsOrange";

          "routes.ts".hl = "MiniIconsGreen";

          ".gitlab-ci.yml".glyph = "";

          temp.glyph = "";
          tmp.glyph = "";
        };
      };
    };
  };
}
