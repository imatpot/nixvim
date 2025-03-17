{lib, ...}: {
  options = {
    modules.themes.all.enable = lib.mkEnableOption "all configured themes";
  };
}
