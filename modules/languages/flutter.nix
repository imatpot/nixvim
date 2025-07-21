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
          if &filetype !=# 'yaml.pubspec'
            finish
          endif

          runtime! -buffer ftplugin/yaml.vim
        '';

      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>a" "<CMD>PubspecAssistAddPackage<CR>" "Add package")
        (mkBufferKeymap' "<localleader>A" "<CMD>PubspecAssistAddDevPackage<CR>" "Add dev package")
        (mkBufferKeymap' "<localleader>v" "<CMD>PubspecAssistPickVersion<CR>" "Pick version")
        (mkBufferKeymap' "<localleader>g" "<CMD>FlutterPubGet<CR>" "Pub get")
        (mkBufferKeymap' "<localleader>u" "<CMD>FlutterPubUpgrade<CR>" "Pub upgrade")
      ];
    };

    "ftplugin/dart.lua" = {
      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<leader>ds" "<CMD>lua if require('dap').session() ~= nil then require('dap').continue() else vim.cmd('FlutterRun') end<CR>" "Start / Continue")

        (mkBufferKeymap' "<leader>da" "<CMD>FlutterAttach<CR>" "Attach")
        (mkBufferKeymap' "<leader>dr" "<CMD>FlutterReload<CR>" "Hot-Relod")
        (mkBufferKeymap' "<leader>dR" "<CMD>FlutterRestart<CR>" "Hot-Restart")
        (mkBufferKeymap' "<leader>dQ" "<CMD>FlutterDetach<CR>" "Detach")

        (mkBufferKeymap' "<localleader>e" "<CMD>FlutterEmulators<CR>" "Emulators")
        (mkBufferKeymap' "<localleader>d" "<CMD>FlutterDevices<CR>" "Devices")
        (mkBufferKeymap' "<localleader>o" "<CMD>FlutterOutlineToggle<CR>" "Outline")
        (mkBufferKeymap' "<localleader>i" "<CMD>FlutterDevTools<CR>" "Dev-Tools")
        (mkBufferKeymap' "<localleader>l" "<CMD>FlutterLogToggle<CR>" "Toggle logs")
        (mkBufferKeymap' "<localleader>c" "<CMD>FlutterLogClear<CR>" "Clear logs")
        (mkBufferKeymap' "<localleader>g" "<CMD>FlutterPubGet<CR>" "Pub get")
        (mkBufferKeymap' "<localleader>u" "<CMD>FlutterPubUpgrade<CR>" "Pub upgrade")
      ];
    };
  };
}
