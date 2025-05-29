{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage config "dart"
{
  flutter.enable =
    lib.utils.mkDefaultEnableOption
    config.modules.languages.dart.enable
    "flutter";
}
{
  plugins = {
    lsp.servers.dartls = {
      enable = true;

      settings = {
        showTodos = true;
        updateImportsOnRename = true;
        enableSnippets = true;
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.dart = ["dart_format"];
      formatters.dart_format = {
        command = "fvm";
        args = ["dart" "format" "$FILENAME"];
        stdin = false;
      };
    };

    dap = {
      adapters = {
        executables = {
          dart = {
            command = "fvm";
            args = ["dart" "debug_adapter"];
          };

          flutter = lib.mkIf config.modules.languages.dart.flutter.enable {
            command = "fvm";
            args = ["flutter" "debug_adapter"];
          };
        };
      };

      configurations = {
        dart = [
          {
            name = "Dart";
            type = "dart";
            request = "launch";
            autoReload.enable = true;
          }

          (lib.mkIf config.modules.languages.dart.flutter.enable {
            name = "Flutter";
            type = "flutter";
            request = "launch";
            autoReload.enable = true;
          })
        ];
      };
    };

    flutter-tools.enable = config.modules.languages.dart.flutter.enable;
  };
}
