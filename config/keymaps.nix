{...}: {
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    keymaps = [
      {
        key = "D";
        action = ''"_d'';
        mode = ["n" "v"];
        options.desc = "Delete and discard";
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
        key = "<leader><down>";
        action = ":%!sort<CR>";
        mode = ["n" "v"];
        options.desc = "Sort lines";
      }

      {
        key = "<leader>q";
        action = "<CMD>q<CR>";
        mode = ["n" "v"];
        options.desc = "Quit";
      }
      {
        key = "<leader>Q";
        action = "<CMD>qa<CR>";
        mode = ["n" "v"];
        options.desc = "Quit all";
      }
      {
        key = "<leader>s";
        action = "<CMD>w<CR>";
        mode = ["n" "v"];
        options.desc = "Save";
      }
      {
        key = "<leader>S";
        action = "<CMD>wa<CR>";
        mode = ["n" "v"];
        options.desc = "Save all";
      }

      {
        key = "<leader>l";
        action = "<CMD>set cursorline!<CR>";
        mode = ["n" "v"];
        options.desc = "Toggle cursorline";
      }
      {
        key = "<leader>L";
        action = "<CMD>set cursorcolumn!<CR>";
        mode = ["n" "v"];
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
        key = "<C-d>";
        action = "£";
        mode = ["n"];
        options.desc = "Go to previous occurence";
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
        key = " ";
        action = "<nop>";
        mode = "n";
        options.desc = "Disable space motions";
      }
      {
        key = "<bslash>";
        action = "<nop>";
        mode = "n";
        options.desc = "Disable backslash motions";
      }
    ];
  };
}
