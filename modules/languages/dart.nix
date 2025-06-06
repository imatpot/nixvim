{
  config,
  lib,
  pkgs,
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

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = pubspec-assist;
      config =
        lib.utils.viml.fromLua
        # lua
        ''
          require("pubspec-assist").setup()
        '';
    }
  ];

  filetype = {
    extension.arb = "json";
    filename."pubspec.yaml" = "yaml.pubspec";
  };

  files = {
    "ftplugin/yaml_pubspec.vim" = {
      extraConfigVim =
        # vim
        ''
          runtime! -buffer ftplugin/yaml.vim
        '';

      keymaps = [
        {
          key = "<localleader>a";
          action = "<CMD>PubspecAssistAddPackage<CR>";
          options = {
            desc = "Add package";
            buffer = true;
          };
        }
        {
          key = "<localleader>A";
          action = "<CMD>PubspecAssistAddDevPackage<CR>";
          options = {
            desc = "Add dev package";
            buffer = true;
          };
        }
        {
          key = "<localleader>v";
          action = "<CMD>PubspecAssistPickVersion<CR>";
          options = {
            desc = "Pick version";
            buffer = true;
          };
        }
        {
          key = "<localleader>g";
          action = "<CMD>FlutterPubGet<CR>";
          options = {
            desc = "Pub get";
            buffer = true;
          };
        }
        {
          key = "<localleader>u";
          action = "<CMD>FlutterPubUpgrade<CR>";
          options = {
            desc = "Pub upgrade";
            buffer = true;
          };
        }
      ];
    };

    "ftplugin/dart.lua" = {
      keymaps = [
        {
          key = "<leader>ds";
          action = "<CMD>lua if require('dap').session() ~= nil then require('dap').continue() else vim.cmd('FlutterRun') end<CR>";
          options = {
            desc = "Start / Continue";
            buffer = true;
          };
        }
        {
          key = "<leader>da";
          action = "<CMD>FlutterAttach<CR>";
          options = {
            desc = "Attach";
            buffer = true;
          };
        }
        {
          key = "<leader>dr";
          action = "<CMD>FlutterReload<CR>";
          options = {
            desc = "Hot-Relod";
            buffer = true;
          };
        }
        {
          key = "<leader>dR";
          action = "<CMD>FlutterRestart<CR>";
          options = {
            desc = "Hot-Restart";
            buffer = true;
          };
        }
        {
          key = "<leader>dQ";
          action = "<CMD>FlutterDetach<CR>";
          options = {
            desc = "Detach";
            buffer = true;
          };
        }
        {
          key = "<localleader>e";
          action = "<CMD>FlutterEmulators<CR>";
          options = {
            desc = "Emulators";
            buffer = true;
          };
        }
        {
          key = "<localleader>d";
          action = "<CMD>FlutterDevices<CR>";
          options = {
            desc = "Devices";
            buffer = true;
          };
        }
        {
          key = "<localleader>o";
          action = "<CMD>FlutterOutlineToggle<CR>";
          options = {
            desc = "Outline";
            buffer = true;
          };
        }
        {
          key = "<localleader>i";
          action = "<CMD>FlutterDevTools<CR>";
          options = {
            desc = "Dev-Tools";
            buffer = true;
          };
        }
        {
          key = "<localleader>l";
          action = "<CMD>FlutterLogToggle<CR>";
          options = {
            desc = "Toggle logs";
            buffer = true;
          };
        }
        {
          key = "<localleader>c";
          action = "<CMD>FlutterLogClear<CR>";
          options = {
            desc = "Clear logs";
            buffer = true;
          };
        }
        {
          key = "<localleader>g";
          action = "<CMD>FlutterPubGet<CR>";
          options = {
            desc = "Pub get";
            buffer = true;
          };
        }
        {
          key = "<localleader>u";
          action = "<CMD>FlutterPubUpgrade<CR>";
          options = {
            desc = "Pub upgrade";
            buffer = true;
          };
        }
      ];
    };
  };
}
