{ config, lib, ... }:
{
  options.user.defaultUser = lib.mkOption {
    type = lib.types.str;
    default = "david";
    description = "The name of the default user.";
  };
  config = {
    users.users.${config.user.defaultUser} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "KVM"
        "docker"
        "input"
        "wireshark"
        "usbusers"
        "uinput"
      ];
    };

    nix.settings.trusted-users = [
      "root"
      config.user.defaultUser
    ];
  };
}
