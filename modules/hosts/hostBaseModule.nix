{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [ "x86_64-linux" ];

  flake.modules.nixos.hostBaseModule =
    {
      inputs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
        inputs.nur.modules.nixos.default
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
      ];

      options = {
        my.user = lib.mkOption {
          type = lib.types.str;
          default = "david";
          description = "My username";
        };
      };
      config = {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
          inputs.nix-vscode-extensions.overlays.default
        ];

        home-manager = {
          extraSpecialArgs = {
            inherit inputs;
          };
          useGlobalPkgs = true;
          useUserPackages = true;
        };

      };
    };
}
