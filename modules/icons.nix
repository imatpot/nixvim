{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "icons" true {
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules.icons.enabled = true;
  };
}
