{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    pin.url = "github:nixos/nixpkgs?ref=940d545355d5e79859502334f2fe269c3996046b";
    # anyrun.url = "github:anyrun-org/anyrun";
    # anyrun.inputs.nixpkgs.follows = "nixpkgs";
    #
    # ags.url = "github:Aylur/ags";

    stylix.url = "github:danth/stylix?rev=04afcfc0684d9bbb24bb1dc77afda7c1843ec93b";

    walker.url = "github:abenz1267/walker";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      stylix,
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
            specialArgs = {
              inherit inputs;
            };
            modules = [
              nur.nixosModules.nur
              { nixpkgs.overlays = [ nur.overlay ]; }

              stylix.nixosModules.stylix

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
