{ config, lib, pkgs, ... }:
{
  #imports = [
  #  inputs.nixos-hardware.nixosModueles.common-gpu-nvidia
  #];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nouveau" ];
  #boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
  #boot.extraModprobeConfig = "blacklist nouveau";
  #boot.initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  powerManagement.enable = false;
  #  powerManagement.finegrained = false;
  #  open = false;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.production;
  #};

}


