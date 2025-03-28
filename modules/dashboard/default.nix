{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "dashboard" {
  modules.snacks.enable = true;

  plugins = {
    lazy.enable = true;

    snacks.settings.dashboard = {
      enabled = true;

      sections = [
        (
          helpers.mkRaw "GetPokemonSection()"
        )
        {
          padding = 2;
        }
        {
          section = "keys";
          gap = 1;
        }
      ];

      preset = {
        keys =
          [
            {
              icon = "";
              key = "i";
              desc = "~ Start writing";
              action = ":ene | startinsert";
            }
          ]
          ++ lib.optionals config.modules.telescope.enable [
            {
              icon = "";
              key = "p";
              desc = "~ Open";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = "󱎸";
              key = "P";
              desc = "~ Find";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = "";
              key = "r";
              desc = "~ Recents";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
          ]
          ++ lib.optionals config.modules.toggleterm.enable [
            {
              icon = "";
              key = "g";
              desc = "~ Git";
              action = ":lua ToggleGitUi()";
            }
            {
              icon = "";
              key = "$";
              desc = "~ Terminal";
              action = ":ToggleTerm";
            }
          ]
          ++ [
            {
              icon = "";
              key = "q";
              desc = "~ Quit";
              action = ":q";
            }
          ];
      };
    };
  };

  globals.minitrailspace_disable = true;

  autoCmd = [
    {
      event = "BufNew";
      callback =
        helpers.mkRaw
        # lua
        ''
          function()
            vim.g.minitrailspace_disable = false
          end
        '';
    }
  ];

  extraLuaPackages = rocks: with rocks; [luautf8];
  extraConfigLuaPre = builtins.readFile ./dashboard.lua;

  extraPackages = with pkgs; [
    krabby
    colorized-logs
  ];
}
