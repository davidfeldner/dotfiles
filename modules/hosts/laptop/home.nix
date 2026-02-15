{ self, ... }:
{
  flake.modules.homeManager.laptopHome =
    { ... }:
    {
      imports = [
        self.modules.homeManager.general
      ];
      hyprland.extraMonitorSettings = [ "eDP-1,3072x1920@60,0x0,2" ];
      hyprland.hidpi = true;
    };
}
