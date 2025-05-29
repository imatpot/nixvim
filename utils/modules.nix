{
  lib,
  mkDefaultEnableOption,
  ...
}: rec {
  mkModule = config: default: name: moduleConfig: {
    options.modules.${name}.enable = mkDefaultEnableOption default name;
    config =
      lib.mkIf config.modules.${name}.enable
      moduleConfig;
  };

  mkLanguage = config: language: languageOptions: languageConfig: {
    options.modules.languages.${language} = {
      enable =
        mkDefaultEnableOption config.modules.languages.all.enable
        language;
    } // languageOptions;

    config =
      lib.mkIf config.modules.languages.${language}.enable
      languageConfig;
  };

  mkLanguage' = config: language: languageConfig:
    mkLanguage config language {} languageConfig;

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
