{ inputs, self, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.modules.nixos; [
      hostBaseModule
      laptopModule
    ];

  };

  flake.modules.nixos.laptopModule =
    { config, pkgs, ... }:
    {
      imports = [
        ./_hardware-configuration.nix
      ]
      ++ (with self.modules.nixos; [
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
        sops
        arduino
        rocm
      ]);

      networking.hostName = "laptop";

      home-manager.users."${config.my.user}".imports = [ self.modules.homeManager.laptopHome ];
    };
}
