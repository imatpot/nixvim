{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "javascript, typescript" {
  plugins = {
    lsp.servers = {
      eslint.enable = true;
      ts_ls.enable = true;
      angularls.enable = true;

      denols = {
        enable = false; # FIXME: https://github.com/neovim/nvim-lspconfig/issues/3728#issuecomment-2966741537
        settings = {
          root_markers = ["deno.json" "deno.jsonc"];
          workspace_required = true;
        };
      };
    };

    lint = {
      linters.eslint_d.cmd = lib.getExe pkgs.eslint_d;

      lintersByFt = rec {
        javascript = ["eslint_d"];
        typescript = javascript;
      };
    };

    conform-nvim.settings = {
      formatters.prettierd.command = lib.getExe pkgs.prettierd;

      formatters_by_ft = rec {
        javascript = ["prettierd"];
        typescript = javascript;
      };
    };

    package-info = {
      enable = true;
      lazyLoad.settings.ft = ["json.package"];

      settings = {
        hide_unstable_versions = true;
        icons.style = {
          invalid = " ";
          outdated = " ";
          up_to_date = " ";
        };
      };
    };

    dap = {
      adapters.servers.pwa-node = {
        host = "localhost";
        port = "\${port}";
        executable = {
          command = lib.getExe pkgs.vscode-js-debug;
          args = ["\${port}"];
        };
      };

      configurations = rec {
        javascript = typescript;
        typescript = [
          {
            type = "pwa-node";
            request = "launch";
            name = "Run with Node";
            runtimeExecutable = "node";
            runtimeArgs = [
              "--inspect-wait"
            ];
            program = "\${file}";
            cwd = "\${workspaceFolder}";
            attachSimplePort = 9229;
          }
          {
            type = "pwa-node";
            request = "launch";
            name = "Run with Deno";
            runtimeExecutable = "deno";
            runtimeArgs = [
              "run"
              "--inspect-wait"
              "--allow-all"
            ];
            program = "\${file}";
            cwd = "\${workspaceFolder}";
            attachSimplePort = 9229;
          }
        ];
      };
    };
  };

  filetype = {
    filename."package.json" = "json.package";
  };

  files = {
    "ftplugin/json_package.vim" = {
      extraConfigVim =
        # vim
        ''
          if &filetype !=# 'json.package'
            finish
          endif

          runtime! -buffer ftplugin/json.vim
        '';

      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>c" "<CMD>lua require('package-info').change_version()<CR>" "Change version")
        (mkBufferKeymap' "<localleader>d" "<CMD>lua require('package-info').delete()<CR>" "Remove")
        (mkBufferKeymap' "<localleader>i" "<CMD>lua require('package-info').install()<CR>" "Add package")
        (mkBufferKeymap' "<localleader>r" "<CMD>lua require('package-info').show({ force = true })<CR>" "Refresh")
      ];
    };
  };
}
