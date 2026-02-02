{ pkgs, ... }:
{
  imports = [
    ./nfs-client.nix
    ../../modules/hacking.nix
    ../../modules/nvidia.nix
    ../../modules/vfio.nix
    ../../modules/steam.nix
    ../../modules/bluetooth.nix
    ../../modules/safe-eyes.nix
    ../../modules/kanata.nix
    ../../modules/grub.nix
    ../../modules/stylix.nix
    ../../modules/virtualization.nix
    ../../modules/direnv.nix
    ../../modules/docker.nix
    ../../modules/fonts.nix
    ../../modules/tailscale.nix
    ../../modules/hyprland.nix
    ../../modules/audio.nix
    ../../modules/fslexyacc.nix
    ../../modules/graphics.nix
  ];

  #boot.kernelPackages = pkgs.linuxPackages_6_6;

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
}
