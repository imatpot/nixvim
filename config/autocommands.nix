{...}: {
  config = {
    autoCmd = [
      {
        event = ["CmdwinEnter"];
        pattern = ["*"];
        command = "q";
      }
      {
        event = ["InsertEnter" "InsertChange"];
        pattern = ["*"];
        command = "call ForbidReplace()";
      }
      {
        event = ["FocusGained" "CursorHold"];
        pattern = ["*"];
        command = "checktime";
      }
    ];

    extraConfigVim = ''
      function ForbidReplace()
        if v:insertmode isnot# 'i'
          call feedkeys("\<Insert>", "n")
        endif
      endfunction
    '';
  };
}
