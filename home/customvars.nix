{ lib, config, ... }:
{
  options = {
    customvars.amdgpu.enable = lib.mkEnableOption "Enable AMD GPU";
    customvars.nvidia.enable = lib.mkEnableOption "Enable NVIDIA GPU";
  };

  config =
    lib.mkIf config.customvars.enable
      {
      };
}
