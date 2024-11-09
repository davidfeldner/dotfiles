# Credit: https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
let
  gpuIDs = [
    "10de:1b80" # Graphics
    "10de:10f0" # Audio
  ];
in
{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";

  config =
    let
      cfg = config.vfio;
    in
    {
      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 user kvm -"
      ];

      boot = {
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"

          #"nvidia"
          #"nvidia_modeset"
          #"nvidia_uvm"
          #"nvidia_drm"
        ];

        kernelParams =
          [
            # enable IOMMU
            "intel_iommu=on"
          ]
          ++ lib.optional cfg.enable
            # isolate the GPU
            ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };

      hardware.graphics.enable = true;
      environment.systemPackages = with pkgs; [
        virtiofsd
        looking-glass-client
      ];

    };
}
