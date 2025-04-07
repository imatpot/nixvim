{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "icons" {
  plugins = {
    web-devicons.enable = true;
    mini = {
      enable = true;
      mockDevIcons = true;
      modules.icons.enabled = true;
    };
  };
}
