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
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {
            networking.hostName = "laptop";
            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;
          }
          # NUR setup and overlay
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/configuation.nix
          # Main Config
          ./modules/configuration.nix
          ./modules/wifi.nix
          ./modules/hacking.nix
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./hosts/laptop/home.nix;
          }
        ];
      };

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "desktop"; }
          # NUR setup and overlay
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }

          ./hosts/desktop/hardware-configuration.nix
          ./modules/nvidia.nix

          # Main Config
          ./modules/configuration.nix
          ./modules/hacking.nix
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./hosts/desktop/home.nix;
          }
        ];
      };
    };

}
