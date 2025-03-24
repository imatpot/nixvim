{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config false "hardtime" {
  plugins.hardtime.enable = true;
}
