{
  flake.modules.nixos.arduino =
    { config, pkgs, ... }:
    {
      users.users.${config.user.defaultUser}.extraGroups = [
        "usbusers"
        "dialout"
      ];

      environment.systemPackages = with pkgs; [
        arduino-ide
        arduino-cli
      ];

      # Allow non root access to usb device
      services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0660", GROUP="usbusers"
      '';
    };
}
