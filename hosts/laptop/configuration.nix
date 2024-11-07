{ pkgs, ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/wifi.nix
  ];
  networking.hostName = "laptop";
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  nixpkgs.config.rocmSupport = true;
  hardware.graphics.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];

}
