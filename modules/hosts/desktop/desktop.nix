{ inputs, self, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      self.nixosModules.hostBaseModule
      self.nixosModules.desktopModule
    ];

  };

  flake.nixosModules.desktopModule =
    { config, ... }:
    {
      imports = [
        ./_hardware-configuration.nix
      ]
      ++ (with self.nixosModules; [
        base
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

      my.user = "david";

      networking.hostName = "desktop";

      boot.loader.grub.useOSProber = false;
      # Manually add entry since osprober finds extra os, and I can't figure out how to add GRUB_OS_PROBER_SKIP_LIST to grub
      boot.loader.grub.extraEntries = ''
        menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-48DB-FCDA' {
                insmod part_gpt
                insmod fat
                search --no-floppy --fs-uuid --set=root 48DB-FCDA
                chainloader /efi/Microsoft/Boot/bootmgfw.efi
        }
      '';
      environment.variables = {
        # MESA_VK_DEVICE_SELECT = "10de:1b80";
        GSK_RENDERER = "ngl";
      };
      vfio.enable = false; # Isolates GPU for VFIO

      home-manager.users."${config.my.user}".imports = [ self.modules.homeManager.desktopHome ];

    };

}
