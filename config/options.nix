{helpers, ...}: {
  config = {
    enableMan = false;
    clipboard.register = "unnamedplus";

    # viAlias = true;
    # vimAlias = true;

    diagnostic.settings = let
      signs = {
        E = " ";
        W = " ";
        I = " ";
        H = " ";
      };
    in {
      signs.text = [
        signs.E
        signs.W
        signs.I
        signs.H
      ];

      virtual_text = false;
      # {
      #   virt_text_pos = "eol_right_align";
      #   suffix = " ";
      #   prefix =
      #     helpers.mkRaw
      #     # lua
      #     ''
      #       function(diagnostic)
      #         local signs = { "${signs.E}", "${signs.W}", "${signs.I}", "${signs.H}" }
      #         return (signs[diagnostic.severity] or "") .. " "
      #       end
      #     '';
      # };
    };

    opts = {
      mouse = "";
      timeout = false;

      fillchars = {
        eob = " ";
        vert = "│";
      };

      autoindent = true;
      breakindent = true;
      confirm = true;
      cursorline = true;
      expandtab = true;
      filetype = "on";
      ignorecase = true;
      linebreak = true;
      number = true;
      relativenumber = true;
      scrolloff = 10;
      shiftwidth = 2;
      showbreak = "↪ ";
      smartcase = true;
      smartindent = true;
      smarttab = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      undofile = true;
      undolevels = 1000;
      whichwrap = "b,s,>,l,<,h";
      wrap = false;
    };

    globals = {
      loaded_tutor_mode_plugin = 1;
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
    };

    extraConfigLua =
      # lua
      ''
        local virtual_text_handler = vim.diagnostic.handlers.virtual_text

        vim.diagnostic.handlers.virtual_text = {
          hide = virtual_text_handler.hide,
          show = function(namespace, bufnr, diagnostics, opts)
            for _, diagnostic in ipairs(diagnostics) do
              diagnostic.message = diagnostic.message:gsub("%s*\n%s*", " "):gsub("^%s+", ""):gsub("%s+$", "")
            end
            virtual_text_handler.show(namespace, bufnr, diagnostics, opts)
          end,
        }
      '';
  };
}
