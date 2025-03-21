{...}: {
  config = {
    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        key = "U";
        action = "<C-r>";
        mode = "n";
        options.desc = "Redo";
      }

      {
        key = "<C-k>";
        action = "<C-u>";
        mode = "n";
        options.desc = "Jump up half a page";
      }
      {
        key = "<C-j>";
        action = "<C-d>";
        mode = "n";
        options.desc = "Jump down half a page";
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
        key = "<C-d>";
        action = "£";
        mode = ["n"];
        options.desc = "Go to previous occurence";
      }

      {
        key = "<C-l>";
        action = "<CMD>set cursorline!<CR>";
        mode = "n";
        options.desc = "Toggle cursorline";
      }
      {
        key = "<C-c>";
        action = "<CMD>set cursorcolumn!<CR>";
        mode = "n";
        options.desc = "Toggle cursorcolumn";
      }

      {
        key = "<leader>s";
        action = ":%!sort<CR>";
        mode = ["n" "v"];
        options.desc = "Sort lines";
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
