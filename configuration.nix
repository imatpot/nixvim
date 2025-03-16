{
  pkgs,
  utils,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [];
}
