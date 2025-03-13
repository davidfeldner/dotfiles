{ pkgs, ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/wifi.nix
    ../../modules/steam.nix
    ../../modules/bluetooth.nix
    ../../modules/vagrant.nix
    ../../modules/safe-eyes.nix
  ];
  networking.hostName = "laptop";

  nixpkgs.config.rocmSupport = true;
  hardware.graphics.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];

}
