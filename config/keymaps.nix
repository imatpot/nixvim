{lib, ...}: {
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    keymaps = with lib.utils.keymaps; [
      (mkKeymap' "D" ''"_d'' "Delete and discard")
      (mkKeymap' "U" "<C-r>" "Redo")

      (mkKeymap ["n"] "<" "<<" "Decrease indent")
      (mkKeymap ["n"] ">" ">>" "Increase indent")
      (mkKeymap ["x"] "<" "<gv" "Decrease indent")
      (mkKeymap ["x"] ">" ">gv" "Increase indent")

      (mkKeymap' "<leader><down>" ":%!sort<CR>" "Sort lines")

      (mkKeymap' "<leader>l" "<CMD>set cursorline!<CR>" "Toggle cursorline")
      (mkKeymap' "<leader>L" "<CMD>set cursorcolumn!<CR>" "Toggle cursorcolumn")
      (mkKeymap' "<leader> " "<CMD>nohlsearch<CR>" "Turn off highlighted matches")
      (mkKeymap' "<leader><Esc>" "<CMD>nohlsearch<CR>" "Turn off highlighted matches")

      (mkKeymap' "<leader>:" ":lua " "Run Lua")
      (mkKeymap' "<leader>R" ":%s/" "Find and replace")

      (mkKeymap ["n"] "<C-d>" "£" "Go to previous occurence")
      (mkKeymap ["n"] "<C-k>" "<C-u>" "Jump up half a page")
      (mkKeymap ["n"] "<C-j>" "<C-d>" "Jump down half a page")

      (mkKeymap ["n"] "Q" "@q" "Run macro")

      (mkKeymap' " " "<nop>" "Disable space motions")
      (mkKeymap' "<bslash>" "<nop>" "Disable backslash motions")

      (mkKeymap' "<leader>?" "<CMD>lua require('which-key').show()<CR>" "Show keymaps")
    ];
  };
}
