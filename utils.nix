{
  inputs,
  system,
  lib,
  ...
}: rec {
  umport = inputs.nypkgs.lib.${system}.umport;

  luaToViml = str: ''
    lua << trim EOF
      ${str}
    EOF
  '';

  joinViml = str:
    lib.concatStringsSep " | "
    (lib.filter (line: line != "") (lib.splitString "\n" str));

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
