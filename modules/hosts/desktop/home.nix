{ self, ... }:
{
  flake.modules.homeManager.desktopHome =
    { pkgs, ... }:
    {
      imports = [
        self.modules.homeManager.general
      ];
      hyprland.extraMonitorSettings = [
        "DVI-D-1, 1440x900,      4480x0, 1"
        "DP-2,    2560x1440@144, 1920x0, 1, vrr, 1"
        "DP-3,    2560x1440@144, 1920x0, 1, vrr, 1"
        "DP-4,    2560x1440@144, 1920x0, 1, vrr, 1"
        "HDMI-A-2, disable"
        "HDMI-A-4, disable"
        "HDMI-A-5, disable"
        "HDMI-A-1, disable"
        "Unknown-1, disable"
      ];
      hyprland.extraWorkspaceSettings = [
        "1,monitor:DP-2,default:true"
        "8,monitor:DVI-D-1,default:true"
        "9,monitor:DVI-D-1"
      ];
      home.packages = with pkgs; [
        grub2
      ];
      zsh.dualboot = true;
      fish.dualboot = true;
    };
}
