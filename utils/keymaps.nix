{...}: rec {
  mkKeymap = mode: key: action: desc: {
    key = key;
    action = action;
    mode = mode;
    options.desc = desc;
  };

  mkKeymap' = mkKeymap "";
}
