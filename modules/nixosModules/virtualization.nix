_: {
  flake.nixosModules.virtualization = {
    virtualisation.libvirtd = {
      enable = false;
      qemu = {
        swtpm.enable = false;
      };
    };
    programs.virt-manager.enable = true;
  };
}
