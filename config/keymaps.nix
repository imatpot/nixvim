{helpers, ...}: {
  config = {
    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        key = "<C-k>";
        action = "<C-u>";
        mode = "n";
      }
      {
        key = "<C-j>";
        action = "<C-d>";
        mode = "n";
      }

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
        key = "<leader> ";
        action = "<CMD>nohlsearch<CR>";
        options.desc = "Turn off highlighted matches";
      }
      {
        key = "<leader><Esc>";
        action = "<CMD>nohlsearch<CR>";
        options.desc = "Turn off highlighted matches";
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
