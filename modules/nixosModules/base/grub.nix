{ ... }:
{
  flake.nixosModules.base-grub =
    { ... }:
    {
      boot.loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          configurationLimit = 20;
        };
      };
    };
}
