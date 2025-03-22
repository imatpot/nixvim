{
  lib,
  mkDefaultEnableOption,
  ...
}: {
  mkSimple = config: default: name: moduleConfig: {
    options.modules.${name}.enable = mkDefaultEnableOption default name;
    config =
      lib.mkIf config.modules.${name}.enable
      moduleConfig;
  };

  mkLanguage = config: language: moduleConfig: {
    options.modules.languages.${language} = {
      enable =
        mkDefaultEnableOption config.modules.languages.all.enable
        language;

      lsp.enable =
        mkDefaultEnableOption config.modules.languages.${language}.enable
        "${language} lsp";

      linter.enable =
        mkDefaultEnableOption config.modules.languages.${language}.enable
        "${language} linter";

      formatter.enable =
        mkDefaultEnableOption config.modules.languages.${language}.enable
        "${language} formatter";
    };

    config =
      lib.mkIf config.modules.languages.${language}.enable
      moduleConfig;
  };

  mkTheme = config: name: moduleConfig: {
    options.modules.themes.${name}.enable =
      mkDefaultEnableOption
      config.modules.themes.all.enable
      name;

    config =
      lib.mkIf config.modules.themes.${name}.enable
      moduleConfig;
  };
}
