{ ... }:
{
  users.users.david = {
    isNormalUser = true;
    description = "david";
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
    "david"
  ];
}
