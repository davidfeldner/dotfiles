{ self, ... }:
{
  flake.modules.homeManager.laptopHome =
    { ... }:
    {
      imports = [
        self.modules.homeManager.general
      ];
      hyprland.extraMonitorSettings = [
        {
          output = "eDP-1";
          mode = "3072x1920@60";
          position = "0x0";
          scale = "2";
        }
      ];
      hyprland.hidpi = true;
    };
}
