{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      systems = [
        {
          name = "desktop";
          arch = "x86_64-linux";
        }
        {
          name = "laptop";
          arch = "x86_64-linux";
        }
      ];
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (system: {
          name = system.name;
          value = nixpkgs.lib.nixosSystem {
            system = system.arch;
            modules = [
              nur.nixosModules.nur
              { nixpkgs.overlays = [ nur.overlay ]; }
              ./hosts/${system.name}/hardware-configuration.nix
              ./hosts/${system.name}/configuration.nix
              ./modules/configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.david = import ./hosts/${system.name}/home.nix;
              }
            ];
          };

        }) systems
      );
    };
}
