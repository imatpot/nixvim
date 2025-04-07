{...}: {
  config = {
    enableMan = false;
    clipboard.register = "unnamedplus";

    # viAlias = true;
    # vimAlias = true;

    diagnostics = {
      signs.text = ["" "" "" ""];
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
    };

    globals = {
      loaded_tutor_mode_plugin = 1;
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
    };
  };
}
