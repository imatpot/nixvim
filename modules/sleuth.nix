{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "sleuth" {
  plugins.sleuth.enable = true;
}
