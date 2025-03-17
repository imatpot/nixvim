{...}: {
  config = {
    enableMan = false;
    clipboard.register = "unnamedplus";

    viAlias = true;
    vimAlias = true;

    opts = {
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
      showbreak = "↪";
      smartcase = true;
      smartindent = true;
      smarttab = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      undofile = true;
      undolevels = 1000;
    };
  };
}
