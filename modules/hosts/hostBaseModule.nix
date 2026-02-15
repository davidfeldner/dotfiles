{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [ "x86_64-linux" ];

  flake.nixosModules.hostBaseModule =
    {
      inputs,
      lib,
      config,
      ...
    }:
    {
      imports = [
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
        nixpkgs.config.permittedInsecurePackages = [
          "dotnet-sdk-6.0.428"
          "dotnet-runtime-6.0.36"
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
