{ ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/nvidia.nix
  ];
  networking.hostName = "desktop";
  boot.loader.grub.useOSProber = true;
  #environment.variables = {
#	GSK_RENDERER = "gl";
 # };
}
