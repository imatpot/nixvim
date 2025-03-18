{
  config,
  lib,
  helpers,
  pkgs,
  ...
}: {
  options = {
    modules.completions.enable = lib.utils.mkDefaultEnableOption true "completions";
    modules.completions.copilot.enable = lib.utils.mkDefaultEnableOption true "copilot";
  };

  config = let
    mkSources = sources:
      map (source:
        if lib.isAttrs source
        then source
        else {
          name = source;
          group_index = 2;
        })
      sources;
  in
    lib.mkIf config.modules.completions.enable {
      plugins = {
        luasnip.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;

          cmdline = let
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
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
            snippet.expand = "function(args) luasnip.lsp_expand(args.body) end";

            formatting = {
              fields = ["kind" "abbr" "menu"];
              format = ''
                function(entry, vim_item)
                  local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                  local strings = vim.split(kind.kind, "%s", { trimempty = true })
                  kind.kind = " " .. (strings[1] or "") .. " "
                  kind.menu = "    " .. (strings[2] or "")

                  return kind
                end
              '';
            };

            window = {
              completion = {
                scrollbar = false;
                scrolloff = 2;
                border = "rounded";
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
                col_offset = -4;
                side_padding = 0;
              };
              documentation = {
                border = "rounded";
                maxHeight = "math.floor(vim.o.lines / 2)";
              };
            };

            sources = mkSources (
              lib.optional config.modules.completions.copilot.enable "copilot"
              ++ [
                "nvim_lsp"
                "async_path"
                "buffer"
                "calc"
                "digraphs"
                "emoji"
                "greek"
                "nvim_lsp_signature_help"
                "treesitter"
                "luasnip"
                {
                  name = "rg";
                  keyword_length = 3;
                }
              ]
            );

            mapping = {
              "<C-Space>" = ''
                cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.close()
                  else
                    cmp.complete()
                  end
                end, { "i", "n", "v" })
              '';

              "<Down>" = ''
                cmp.mapping(function(fallback)
                  if not cmp.visible() then
                    fallback()
                  elseif cmp.visible() then
                    cmp.select_next_item()
                  elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
                    cmp.complete()
                  else
                    fallback()
                  end
                end, { "i", "s" })
              '';

              "<Up>" = ''
                cmp.mapping(function(fallback)
                  if not cmp.visible() then
                    fallback()
                  elseif cmp.visible() then
                    cmp.select_prev_item()
                  elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
                    cmp.complete()
                  else
                    fallback()
                  end
                end, { "i", "s" })
              '';

              "<CR>" = ''
                cmp.mapping({
                  i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                      if luasnip.expandable() then
                        luasnip.expand()
                      else
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                      end
                    else
                      fallback()
                    end
                  end,
                  s = cmp.mapping.confirm({ select = false }),
                  c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                })
              '';

              "<C-j>" = "cmp.mapping.scroll_docs(-4)";
              "<C-k>" = "cmp.mapping.scroll_docs(4)";

              "<Esc>" = ''
                cmp.mapping(function(fallback)
                  if cmp.visible() and cmp.get_active_entry() then
                    cmp.abort()
                  else
                    fallback()
                  end
                end)
              '';
            };
          };
        };
      };

      extraPackages = with pkgs; [
        ripgrep
      ];

      extraPlugins = with pkgs.vimPlugins; [
        lspkind-nvim
      ];

      extraConfigLuaPre = ''
        luasnip = require("luasnip")
      '';
    };
}
