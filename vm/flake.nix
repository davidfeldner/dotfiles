{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
  outputs = { self, nixpkgs, nixos-generators, nur, home-manager, ... }: {
    packages.x86_64-linux = {
      empty = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          # NUR setup and overlay
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }

          ./vm.nix
          ./modules/vpn.nix
          home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./home.nix;
          }
        ];
        format = "qcow";
        specialArgs = {
            diskSize = 20 * 1024;
        };
      };
    };
  };
}
