{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "docker" {
  plugins = {
    lsp.servers = {
      dockerls = {
        enable = true;
        packageFallback = true;
      };

      docker_compose_language_service = {
        enable = true;
        packageFallback = true;
      };
    };

    # TODO: https://github.com/reteps/dockerfmt

    lint = {
      linters.hadolint.cmd = lib.getExe pkgs.hadolint;
      lintersByFt.dockerfile = ["hadolint"];
    };
  };
}
