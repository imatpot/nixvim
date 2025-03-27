{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config false "hardtime" {
  plugins.hardtime.enable = true;
}
