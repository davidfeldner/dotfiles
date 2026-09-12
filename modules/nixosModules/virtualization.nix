{
  flake.modules.nixos.virtualization = { config, pkgs, ... }: {
    users.users.${config.user.defaultUser}.extraGroups = [
      "libvirtd"
      "KVM"
    ];
    virtualisation.libvirtd = {
      enable = true;
    };
    programs.virt-manager.enable = true;
    environment.systemPackages = [ pkgs.virtiofsd ];
  };
}
