{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "dart"
{
  plugins = {
    conform-nvim.settings.formatters_by_ft.dart.lsp_format = "prefer";

    flutter-tools = {
      enable = true;

      settings = {
        fvm = true;
        dev_log.enabled = false;
        debugger.enabled = true;
        closing_tags.enabled = false;
      };
    };
  };

  files."ftplugin/dart.lua" = {
    keymaps = [
      {
        key = "<leader>ds";
        action = "<CMD>lua if require('dap').session() ~= nil then require('dap').continue() else vim.cmd('FlutterRun') end<CR>";
        options.desc = "Start / Continue";
      }
      {
        key = "<leader>dr";
        action = "<CMD>FlutterReload<CR>";
        options.desc = "Hot-Relod";
      }
      {
        key = "<leader>dR";
        action = "<CMD>FlutterRestart<CR>";
        options.desc = "Hot-Restart";
      }
      {
        key = "<leader>dE";
        action = "<CMD>FlutterEmulators<CR>";
        options.desc = "Emulators";
      }
      {
        key = "<leader>dD";
        action = "<CMD>FlutterDevices<CR>";
        options.desc = "Devices";
      }
    ];
  };
}
