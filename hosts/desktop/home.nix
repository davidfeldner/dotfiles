{ ... }:

{
  imports = [ ../../home/general.nix ];
  hyprland.extraMonitorSettings = [
    "DVI-D-1, 1440x900,      4480x0, 1"
    "DP-2,    2560x1440@144, 1920x0, 1"
    "HDMI-A-2, disable"
  ];
  hyprland.nvidia = true;
}
