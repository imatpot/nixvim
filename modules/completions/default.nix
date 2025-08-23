{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "completions" {
  unicode.enable = lib.utils.mkDefaultEnableOption config.modules.completions.enable "unicode";
}
{
  performance.combinePlugins.standalonePlugins = [
    "blink.cmp"
    "friendly-snippets" # https://github.com/nix-community/nixvim/issues/2746
  ];

  plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;

    lspkind = {
      enable = true;
      cmp.enable = true;
    };

    colorful-menu.enable = true;

    blink-cmp = {
      enable = true;
      luaConfig.pre = builtins.readFile ./completions.lua;

      settings = {
        sources = {
          default =
            [
              "path"
              "lsp"
              "snippets"
              "buffer"
              "ripgrep"
              "calc"
              "dotenv"
            ]
            ++ lib.optionals config.modules.copilot.enable [
              "copilot"
            ]
            ++ lib.optionals config.modules.completions.unicode.enable [
              "unicode"
            ];

          per_filetype = let
            dapSources = ["dap"];
          in {
            dap-repl = dapSources;
            dapui_hover = dapSources;
            dapui_watches = dapSources;
          };

          providers = let
            useKindName = name: lib.nixvim.mkRaw "blink_config.use_kind_name('${name}')";
          in {
            buffer.min_keyword_length = 5;
            snippets.min_keyword_length = 3;

            copilot = lib.mkIf config.modules.copilot.enable {
              async = true;
              name = "copilot";
              module = "blink-copilot";
              score_offset = 100;
              opts = {
                max_completions = 1;
                max_attempts = 2;
                debounce = 100;
                auto_refresh = {
                  backward = false;
                  forward = false;
                };
              };
            };

            unicode = lib.mkIf config.modules.completions.unicode.enable {
              async = true;
              name = "unicode";
              module = "blink.compat.source";
              score_offset = -90;
              transform_items = useKindName "Unicode";
            };

            ripgrep = {
              async = true;
              name = "ripgrep";
              module = "blink-ripgrep";
              score_offset = -100;
              opts = {
                project_root_marker = []; # always use cwd
                search_casing = "--smart-case";
              };
            };

            calc = {
              async = true;
              name = "calc";
              module = "blink.compat.source";
              score_offset = -10;
              transform_items = useKindName "Calc";
            };

            dap = {
              name = "dap";
              module = "blink.compat.source";
              transform_items = useKindName "DAP";
            };

            dotenv = {
              name = "dotenv";
              module = "blink.compat.source";
              transform_items = useKindName "Env";
              score_offset = -100;
              opts = {
                load_shell = true;
              };
            };
          };
        };

        signature.enabled = true;

        completion = {
          list.selection = {
            preselect = false;
            auto_insert = false;
          };

          menu = {
            border = "rounded";
            scrolloff = 3;

            min_width = 20;
            max_height = lib.nixvim.mkRaw "math.floor(vim.o.lines / 3)";

            draw = {
              gap = 2;
              padding = [1 2];

              columns = [
                ["kind_icon"]
                ["label"]
              ];

              components = {
                label = {
                  text = lib.nixvim.mkRaw "blink_config.colorize_text";
                  highlight = lib.nixvim.mkRaw "blink_config.colorize_highlights";
                };
              };
            };
          };

          documentation = {
            window.border = "rounded";
            auto_show = true;
            auto_show_delay_ms = 0;
          };
        };

        cmdline = {
          keymap.preset = "inherit";
          completion = {
            menu.auto_show = true;
            list.selection = {
              preselect = false;
              auto_insert = false;
            };
          };
        };

        appearance = {
          use_nvim_cmp_as_default = true;

          kind_icons = {
            Event = "";
            Keyword = "󰌆";
            Operator = "󱓉";
            Reference = "";
            Snippet = "";
            TypeParameter = "󱗽";
            Unit = "";
            Variable = "󰆧";

            Calc = "";
            DAP = "";
            Env = "";
            Unicode = "󰻐";
          };
        };

        keymap = {
          # https://cmp.saghen.dev/configuration/keymap.html#commands
          # https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/init.lua

          preset = "enter";

          "<C-space>" = [
            "show"
            "hide"
          ];

          "<down>" = [
            "select_next"
            "fallback"
          ];

          "<up>" = [
            "select_prev"
            "fallback"
          ];

          "<C-j>" = [
            "scroll_documentation_down"
            "fallback"
          ];

          "<C-l>" = [
            "scroll_documentation_up"
            "fallback"
          ];

          "<tab>" = [
            "snippet_forward"
            (lib.nixvim.mkRaw "blink_config.indent_if_no_words_before")
            "fallback"
          ];

          "<S-tab>" = [
            "snippet_backward"
            "fallback"
          ];

          "<esc>" = [
            (lib.nixvim.mkRaw "blink_config.cancel")
          ];
        };
      };
    };

    blink-copilot.enable = lib.mkIf config.modules.copilot.enable true;
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;

    blink-compat = {
      enable = true;
      settings.impersonate_nvim_cmp = true;
    };

    cmp-calc.enable = true;
    cmp-dap.enable = true;
  };

  autoCmd = lib.optionals config.modules.completions.unicode.enable [
    {
      event = ["VimEnter"];
      pattern = ["*"];
      callback = lib.nixvim.mkRaw "unicode.populate_completions";
    }
  ];

  extraPackages = with pkgs; [
    ripgrep
  ];

  extraLuaPackages = rocks:
    with rocks; [
      luautf8
    ];

  extraPlugins = with pkgs.vimPlugins;
    [
      cmp-dotenv
    ]
    ++ lib.optionals config.modules.completions.unicode.enable [
      unicode-vim
    ];
}
