{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "otter" {
  plugins.otter = {
    enable = true;
    settings = {
      handle_leading_whitespace = true;

      lsp.diagnostic_update_events = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];

      buffers = {
        preambles = {
          lua = [
            # lua
            "---@diagnostic disable: trailing-space, undefined-global"
          ];
        };
      };
    };
  };

  extraConfigLuaPre =
    # lua
    ''
      local original_diagnostics_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

      function OtterDiagnosticsFilter(err, result, ctx, config)
        if not result or not result.diagnostics then return end

        local bufnr = vim.uri_to_bufnr(result.uri)

        if bufnr then
          local bufinfo = vim.fn.getbufinfo(bufnr)[1];
          local name = bufinfo.name;

          if name:match("%.otter%.lua$") then
            local filtered_diagnostics = {}
            local ignored_diagnostics = {
              "Unexpected <exp> .",
              "<name> expected.",
              "Missed symbol `\"`.",
              "Miss symbol `,` or `;` ."
            }

            for _, diagnostic in ipairs(result.diagnostics) do
              if not vim.tbl_contains(ignored_diagnostics, diagnostic.message) then
                table.insert(filtered_diagnostics, diagnostic)
              end
            end

            result.diagnostics = filtered_diagnostics
          end
        end

        original_diagnostics_handler(err, result, ctx, config)
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"] = OtterDiagnosticsFilter
    '';
}
