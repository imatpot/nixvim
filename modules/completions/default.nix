{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "completions" {
  unicode.enable = lib.utils.mkDefaultEnableOption config.modules.completions.enable "unicode";
  copilot.enable = lib.utils.mkDefaultEnableOption config.modules.completions.enable "copilot";
}
{
  performance.combinePlugins.standalonePlugins =
    lib.optionals
    config.modules.completions.copilot.enable
    ["copilot.lua"];

  plugins = {
    luasnip.enable = true;

    cmp = let
      mkSources = sources: map mkSource sources;
      mkSource = source:
        if lib.isAttrs source
        then
          {
            group_index = 2;
            keyword_length = 1;
          }
          // source
        else {
          name = source;
          group_index = 2;
          keyword_length = 1;
        };
    in {
      luaConfig.pre = builtins.readFile ./completions.lua;

      enable = true;
      autoEnableSources = true;

      cmdline = let
        mapping =
          helpers.mkRaw
          # lua
          "cmp.mapping.preset.cmdline()";
      in {
        ":" = {
          inherit mapping;
          sources = mkSources [
            "path"
            "cmdline"
            "cmdline_history"
          ];
        };

        "/" = {
          inherit mapping;
          sources = mkSources [
            "buffer"
            "cmdline_history"
            "nvim_lsp_document_symbol"
          ];
        };

        "?" = {
          inherit mapping;
          sources = mkSources [
            "cmdline_history"
          ];
        };
      };

      filetype = let
        dapSources = mkSources ["dap"];
      in {
        dap-repl.sources = dapSources;
        dapui_hover.sources = dapSources;
        dapui_watches.sources = dapSources;
      };

      settings = {
        preselect = "cmp.PreselectMode.None";

        matching.disallowPartialFuzzyMatching = false;
        snippet.expand = "ExpandSnippet";

        formatting = {
          fields = ["kind" "abbr" "menu"];
          format = "FormatCompletion";
        };

        window = {
          completion = {
            scrollbar = true;
            scrolloff = 2;
            border = "rounded";
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
            col_offset = -4;
            side_padding = 0;
          };

          documentation = {
            border = "rounded";
            max_height =
              # lua
              "math.floor(vim.o.lines / 2)";
          };
        };

        sources = mkSources (
          lib.optionals config.modules.completions.copilot.enable [
            "copilot"
          ]
          ++ [
            {
              name = "nvim_lsp";
              keyword_length = 0;
            }
            "nvim_lsp_signature_help"
            "async_path"
            "calc"
            {
              name = "treesitter";
              keyword_length = 3;
            }
            {
              name = "luasnip";
              keyword_length = 3;
            }
          ]
          ++ lib.optionals config.modules.completions.unicode.enable [
            "unicode"
          ]
          ++ [
            {
              name = "buffer";
              keyword_length = 5;
            }
            {
              name = "rg";
              keyword_length = 5;
            }
          ]
        );

        sorting = {
          priority_weight = 2;
          comparators =
            lib.optionals config.modules.completions.copilot.enable [
              "CopilotPriority"
            ]
            ++ lib.optionals config.modules.completions.unicode.enable [
              "UnicodePriority"
            ]
            ++ [
              "cmp.config.compare.offset"
              "cmp.config.compare.exact"
              "cmp.config.compare.score"
              "cmp.config.compare.recently_used"
              "cmp.config.compare.kind"
              "cmp.config.compare.length"
              "cmp.config.compare.order"
            ];
        };

        mapping = {
          "<C-Space>" =
            # lua
            "cmp.mapping(ToggleCompletion, { 'i', 'n', 'v' })";

          "<Down>" =
            # lua
            "cmp.mapping(SelectNextCompletion, { 'i', 's' })";

          "<Up>" =
            # lua
            "cmp.mapping(SelectPreviousCompletion, { 'i', 's' })";

          "<CR>" =
            # lua
            ''
              cmp.mapping({
                i = ConfirmCompletionInsert,
                s = cmp.mapping.confirm({ select = false }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              })
            '';

          "<C-j>" =
            # lua
            "cmp.mapping.scroll_docs(-4)";

          "<C-k>" =
            # lua
            "cmp.mapping.scroll_docs(4)";

          "<Esc>" =
            # lua
            "cmp.mapping(AbortCompletion)";
        };
      };
    };
  };

  autoCmd = lib.optionals config.modules.completions.unicode.enable [
    {
      event = ["VimEnter"];
      pattern = ["*"];
      callback =
        helpers.mkRaw
        # lua
        "function() PopulateUnicodeCompletions() end";
    }
  ];

  extraPackages = with pkgs; [
    ripgrep
  ];

  extraLuaPackages = rocks:
    with rocks; [
      luautf8
    ];

  extraPlugins = with pkgs.vimPlugins; (
    [
      colorful-menu-nvim
      lspkind-nvim
    ]
    ++ lib.optionals config.modules.completions.unicode.enable [
      unicode-vim
    ]
  );
}
