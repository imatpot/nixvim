{
  config,
  lib,
  pkgs,
  ...
}: let
  javaDebugBundles = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
in
  lib.utils.modules.mkLanguage' config "java" {
    plugins = {
      lsp.servers = {
        jdtls = {
          enable = true;
          packageFallback = true;

          extraOptions.init_options.bundles =
            lib.nixvim.mkRaw
            # lua
            ''vim.fn.glob("${javaDebugBundles}", true, true)'';
        };
      };

      conform-nvim.settings = {
        formatters.google-java-format.command = lib.getExe pkgs.google-java-format;

        formatters_by_ft = {
          java = ["google-java-format"];
        };
      };

      dap.configurations.java = [
        {
          type = "java";
          request = "attach";
          name = "Attach to remote JVM";
          hostName = "127.0.0.1";

          port =
            lib.nixvim.mkRaw
            # lua
            ''
              function()
                return tonumber(vim.fn.input("Debug port: ", "5005"))
              end
            '';
        }
      ];
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-jdtls
    ];
  }
