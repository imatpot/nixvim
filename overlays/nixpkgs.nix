{inputs, ...}: self: super: {
  master = import inputs.nixpkgsMaster {
    inherit (super) config overlays;
    system = super.stdenv.hostPlatform.system;
  };
}
