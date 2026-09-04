{ inputs, self, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = with self.modules.nixos; [
      hostBaseModule
      desktopModule
    ];

  };

  flake.modules.nixos.desktopModule =
    { config, ... }:
    {
      imports = [
        ./_hardware-configuration.nix
      ]
      ++ (with self.modules.nixos; [
        base
        steam
        tailscale
        hacking
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
        graphics
        nfs-desktop
        waydroid
        arduino
        rocm
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

      fileSystems."/mnt/ssd" = {
        device = "/dev/disk/by-uuid/89172eaf-f1f0-471f-aef4-bece6c9a1b26";
        fsType = "ext4";
        options = [ "nofail" ];
      };

      environment.variables = {
        # MESA_VK_DEVICE_SELECT = "10de:1b80";
        GSK_RENDERER = "ngl";
      };
      vfio.enable = false; # Isolates GPU for VFIO

      home-manager.users."${config.my.user}".imports = [ self.modules.homeManager.desktopHome ];

    };

}
