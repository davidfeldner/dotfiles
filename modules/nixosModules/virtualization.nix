{
  flake.modules.nixos.virtualization = {
    virtualisation.libvirtd = {
      enable = true;
    };
    programs.virt-manager.enable = true;
  };
}
