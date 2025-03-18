{lib, ...}: {
  options = {
    modules.themes.all.enable = lib.utils.mkDefaultEnableOption true "all configured themes";
  };
}
