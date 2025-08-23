{...}: {
  performance = {
    combinePlugins.enable = false;

    byteCompileLua = {
      enable = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
