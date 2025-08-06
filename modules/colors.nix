{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "colors" {
  plugins = {
    colorizer = {
      enable = true;
      settings = {
        user_default_options = {
          mode = "virtualtext";
          virtualtext = "";
          virtualtext_inline = lib.nixvim.mkRaw "'before'";

          names = true;
          names_opts = {
            lowercase = true;
            camelcase = true;
            uppercase = true;
          };

          css = true;
          css_fn = true;
          sass = {
            enable = true;
            parsers = ["css"];
          };

          tailwind = true;
          xterm = true;
        };
      };
    };

    ccc = {
      enable = true;
      settings.highlighter.auto_enable = false;
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>Ch" "<CMD>ColorizerToggle<CR>" "Toggle colors highlights")
    (mkKeymap' "<leader>Cc" "<CMD>CccConvert<CR>" "Convert color")
    (mkKeymap' "<leader>C/" "<CMD>CccPick<CR>" "Pick color")
  ];
}
