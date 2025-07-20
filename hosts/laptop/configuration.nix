{ pkgs, ... }:
{
  imports = [
    ../../modules/hacking.nix
    ../../modules/wifi.nix
    ../../modules/steam.nix
    ../../modules/bluetooth.nix
    ../../modules/vagrant.nix
    ../../modules/safe-eyes.nix
    ../../modules/kanata.nix
    ../../modules/grub.nix
    ../../modules/stylix.nix
    ../../modules/virtualization.nix
    ../../modules/printing.nix
    ../../modules/direnv.nix
    ../../modules/docker.nix
    ../../modules/fonts.nix
    ../../modules/tailscale.nix
    ../../modules/hyprland.nix
    ../../modules/audio.nix
  ];
  networking.hostName = "laptop";

  nixpkgs.config.rocmSupport = true;
  hardware.graphics.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];

}
