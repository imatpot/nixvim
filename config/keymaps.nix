{...}: {
  config = {
    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        key = "<";
        action = "<<";
        mode = "n";
        options.desc = "Decrease indent";
      }
      {
        key = ">";
        action = ">>";
        mode = "n";
        options.desc = "Increase indent";
      }
      {
        key = "<";
        action = "<gv";
        mode = "x";
        options.desc = "Decrease indent";
      }
      {
        key = ">";
        action = ">gv";
        mode = "x";
        options.desc = "Increase indent";
      }

      {
        key = "<leader>l";
        action = "<CMD>set cursorline!<CR>";
        options.desc = "Toggle cursorline";
      }
      {
        key = "<leader>L";
        action = "<CMD>set cursorcolumn!<CR>";
        options.desc = "Toggle cursorcolumn";
      }

      {
        key = " ";
        action = "<nop>";
        mode = "n";
        options.desc = "Disable space motions";
      }
    ];
  };
}
