{ inputs, self, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      self.nixosModules.hostBaseModule
      self.nixosModules.laptopModule
    ];

  };

  flake.nixosModules.laptopModule =
    { config, pkgs, ... }:
    {
      imports = [
        ./_hardware-configuration.nix
      ]
      ++ (with self.nixosModules; [
        base
        hacking
        wifi
        steam
        bluetooth
        kanata
        grub
        stylix
        virtualization
        printing
        direnv
        docker
        fonts
        tailscale
        hyprland
        audio
        fslexyacc
      ]);

      networking.hostName = "laptop";

      nixpkgs.config.rocmSupport = true;
      hardware.graphics.extraPackages = with pkgs.rocmPackages; [
        clr
        clr.icd
      ];

      home-manager.users."${config.my.user}".imports = [ self.modules.homeManager.laptopHome ];
    };
}
