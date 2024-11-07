{ ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/nvidia.nix
    ../../modules/nixvim.nix
  ];
  networking.hostName = "desktop";
  boot.loader.grub.useOSProber = true;
}
