{
  lib,
  viml,
  ...
}: rec {
  setup' = name: setup name {};
  setup = name: options: let opts = lib.generators.toLua {} options; in viml.fromLua "require('${name}').setup(${opts})";
}
