{
  inputs,
  system,
  ...
}: self: super: {
  alejandra = inputs.alejandra.packages.${system}.default;
}
