{...}: {
  plugins = {
    lz-n.enable = true;
    lazy.enable = false;
  };

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
