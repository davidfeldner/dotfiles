{ inputs, self, ... }:
{

  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      systemName = "desktop";
    };
    modules = [
      inputs.nur.modules.nixos.default
      inputs.stylix.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager

      {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
          inputs.nix-vscode-extensions.overlays.default
        ];
      }
      self.nixosModules.base-fixes
      self.nixosModules.base
      self.nixosModules.desktop
      ./_hardware-configuration.nix

      {
        home-manager = {
          extraSpecialArgs = {
            inherit inputs;
            systemName = "desktop";
          };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.david =
            { ... }:
            {
              imports = [
                self.modules.homeManager.desktop
                self.modules.homeManager.general
                self.modules.homeManager.yazi
              ];
            };
        };
      }

    ]
    ++ (with self.nixosModules; [
      steam
      tailscale
      safeeyes
      hacking
      nvidia
      vfio
      bluetooth
      kanata
      grub
      stylix
      virtualization
      direnv
      docker
      fonts
      hyprland
      audio
      fslexyacc
      graphics
      nfs-desktop
    ]);

  };
}
