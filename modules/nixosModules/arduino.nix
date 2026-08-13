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
    };
}
