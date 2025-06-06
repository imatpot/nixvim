{...}: rec {
  mkKeymap' = mkKeymap "";
  mkKeymap = mode: key: action: desc: {
    inherit mode key action;
    options.desc = desc;
  };

  mkBufferKeymap' = mkBufferKeymap "";
  mkBufferKeymap = mode: key: action: desc: {
    inherit mode key action;
    options = {
      inherit desc;
      buffer = true;
    };
  };
}
