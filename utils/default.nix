args @ {
  inputs,
  system,
  lib,
  ...
}: rec {
  modules = import ./modules.nix (args // {inherit mkDefaultEnableOption;});
  keymaps = import ./keymaps.nix args;
  lua = import  ./lua.nix args;
  viml = import ./viml.nix args;

  umport = inputs.nypkgs.lib.${system}.umport;

  mkDefaultEnableOption = default: name:
    lib.mkOption {
      inherit default;
      type = lib.types.bool;
      example = !default;
      description = "Whether to enable ${name}";
    };

  enable = xs: fill {enable = true;} xs;

  disable = xs: fill {enable = false;} xs;

  fill = value: xs:
    lib.foldl' (acc: x:
      acc
      // lib.setAttrByPath (
        if builtins.isList x
        then x
        else [x]
      )
      value) {}
    xs;
}
