{inputs, ...}: self: super: {
  prettypst = let
    cargoLock = builtins.fromTOML <| builtins.readFile <| inputs.prettypst + "/Cargo.lock";
    package = builtins.head <| builtins.filter (package: package.name == "prettypst") cargoLock.package;
  in
    self.rustPlatform.buildRustPackage {
      inherit (package) version name;
      src = inputs.prettypst;
      cargoLock.lockFile = inputs.prettypst + "/Cargo.lock";
    };
}
