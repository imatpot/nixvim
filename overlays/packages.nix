{inputs, ...}: self: super: {
  prettypst = let
    cargoTOML = builtins.fromTOML <| builtins.readFile <| inputs.prettypst + "/Cargo.toml";
  in
    self.rustPlatform.buildRustPackage {
      inherit (cargoTOML.package) version name;
      src = inputs.prettypst;
      cargoLock.lockFile = inputs.prettypst + "/Cargo.lock";
    };
}
