{
  config,
  lib,
  helpers,
  ...
}: {
  options = {modules.mini.enable = lib.mkEnableOption "mini suite";};

  config = lib.mkIf config.modules.mini.enable {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;

      modules = {
        pairs = {};
        comment = {};
        align = {};
        surround = {};
        move = {};
        trailspace = {};
        tabline = {};
        icons = {};

        files = {
          mappings = {
            go_in_plus = "<Right>";
            go_out_plus = "<Left>";
            synchronize = "w";
          };

          windows = {
            preview = true;
            width_preview = 50;
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        action = "<CMD>lua MiniFiles.open()<CR>";
        options.desc = "Open file browser";
      }
    ];

    autoCmd = [
      {
        event = ["User"];
        pattern = ["MiniFilesBufferCreate"];
        callback = helpers.mkRaw ''
          function(args)
            local map_buf = function(lhs, rhs)
              vim.keymap.set('n', lhs, rhs, { buffer = args.data.buf_id })
            end

            local go_in_plus = function()
              for _ = 1, vim.v.count1 do
                MiniFiles.go_in({ close_on_file = true })
              end
            end

            map_buf('<Esc>', MiniFiles.close)
            map_buf('<CR>', go_in_plus)
            map_buf('<Tab>', go_in_plus)
          end
        '';
      }
      {
        event = ["VimEnter"];
        pattern = ["*"];
        callback = helpers.mkRaw ''
          function()
            if (vim.fn.expand("%") == "") then
              MiniFiles.open()
            end
          end
        '';
      }
    ];
  };
}
