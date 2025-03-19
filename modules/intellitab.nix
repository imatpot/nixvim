{
  config,
  lib,
  ...
}: {
  options = {
    modules.intellitab.enable = lib.utils.mkDefaultEnableOption true "intellitab";
  };

  config = {
    plugins.intellitab.enable = true;
  };
}
