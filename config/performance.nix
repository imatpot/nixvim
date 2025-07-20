{...}: {
  performance = {
    combinePlugins.enable = true;

    byteCompileLua = {
      enable = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
