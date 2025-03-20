{mkDefaultEnableOption, ...}: {
  mkLanguage = config: language: moduleConfig: {
    options.modules.languages.${language} = {
      enable =
        mkDefaultEnableOption config.modules.languages.all.enable
        language;

      lsp.enable =
        mkDefaultEnableOption config.modules.languages.${language}.enable
        "${language} lsp";

      formatter.enable =
        mkDefaultEnableOption config.modules.languages.${language}.enable
        "${language} formatter";
    };

    config = moduleConfig;
  };
}
