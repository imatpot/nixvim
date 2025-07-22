{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "docker" {
  plugins = {
    lsp.servers = {
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
    };

    # TODO: https://github.com/reteps/dockerfmt

    lint = {
      linters.hadolint.cmd = lib.getExe pkgs.hadolint;
      lintersByFt.dockerfile = ["hadolint"];
    };
  };
}
