{
  inputs,
  system,
  ...
}: self: super: {
  alejandra = inputs.alejandra.packages.${system}.default;
  prisma-language-server = inputs.nixpkgsTeapot.legacyPackages.${system}.prisma-language-server;
}
