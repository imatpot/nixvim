{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "icons" {
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules.icons.enabled = true;
  };
}
