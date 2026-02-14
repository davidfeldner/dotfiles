{ ... }:
{
  flake.nixosModules.virtualization = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
