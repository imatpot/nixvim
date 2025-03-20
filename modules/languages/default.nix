{lib, ...}: {
  options.modules.languages.all.enable = lib.utils.mkDefaultEnableOption true "all languages";
}
