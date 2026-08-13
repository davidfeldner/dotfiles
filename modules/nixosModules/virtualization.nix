{
  flake.modules.nixos.virtualization = { config, ... }: {
    users.users.${config.user.defaultUser}.extraGroups = [
      "libvirtd"
      "KVM"
    ];
    virtualisation.libvirtd = {
      enable = true;
    };
    programs.virt-manager.enable = true;
  };
}
