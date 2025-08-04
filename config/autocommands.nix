{helpers, ...}: {
  config = {
    autoCmd = [
      {
        event = ["CmdwinEnter"];
        command = "q";
      }
      {
        event = ["InsertEnter" "InsertChange"];
        command = "call ForbidReplace()";
      }
      {
        event = ["FocusGained" "CursorHold"];
        command = "checktime";
      }
      {
        event = ["BufWritePre"];
        callback = helpers.mkRaw ''
          function (event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
              return
            end

            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      }
    ];

    extraConfigVim =
      # vim
      ''
        function ForbidReplace()
          if v:insertmode isnot# 'i'
            call feedkeys("\<Insert>", "n")
          endif
        endfunction
      '';
  };
}
