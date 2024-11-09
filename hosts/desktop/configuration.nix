{ pkgs, ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/nvidia.nix
    ../../modules/vfio.nix
  ];
  networking.hostName = "desktop";
  boot.loader.grub.useOSProber = true;
  environment.variables = {
    # MESA_VK_DEVICE_SELECT = "10de:1b80";
    GSK_RENDERER = "ngl";
  };
  #   vfio.enable = false; # Isolates GPU for VFIO
}
