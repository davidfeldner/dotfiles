{
  description = "Azure CLI shell with a specific Nixpkgs version";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/89172919243df199fe237ba0f776c3e3e3d72367";

  # Output section
  outputs =
    { self, nixpkgs }:
    {
      devShells = {
        x86_64-linux.default =
          let
            # Define pkgs as the result of importing Nixpkgs
            pkgs = import nixpkgs {
              system = "x86_64-linux";
            };
          in
          pkgs.mkShell {
            buildInputs = [
              pkgs.azure-cli # Use azure-cli from the specific Nixpkgs version
            ];
          };
      };
    };
}
