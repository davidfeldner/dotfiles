{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    };
}
