{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      ...
    }:
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # NUR setup and overlay
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }

          ./hosts/laptop/hardware-configuration.nix
          { networking.hostName = "laptop"; }

          # Main Config
          ./configuration.nix
          ./hacking.nix
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./home.nix;
          }
        ];
      };

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # NUR setup and overlay
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }

          ./hosts/desktop/hardware-configuration.nix
          ./nvidia.nix
          {
            networking.hostName = "desktop";

          }

          # Main Config
          ./configuration.nix
          ./hacking.nix
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./home.nix;
          }
        ];
      };
    };

}
