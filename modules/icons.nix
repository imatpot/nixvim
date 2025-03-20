{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "icons" {
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules.icons.enabled = true;
  };
}
