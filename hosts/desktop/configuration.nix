{ pkgs, ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/nvidia.nix
    ../../modules/vfio.nix
  ];
  networking.hostName = "desktop";
  boot.loader.grub.useOSProber = true;
  #environment.variables = {
#	GSK_RENDERER = "gl";
 # };
  vfio.enable = false; # Isolates GPU for VFIO
}
