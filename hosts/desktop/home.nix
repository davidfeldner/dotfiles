{ pkgs, ... }:

{
  imports = [ ../../home/general.nix ];
  hyprland.extraMonitorSettings = [
    "DVI-D-1, 1440x900,      4480x0, 1"
    "DP-3,    2560x1440@144, 1920x0, 1"
    "HDMI-A-5, disable"
  ];
  hyprland.nvidia = true;
  hyprland.extraWorkspaceSettings = [
    "1,monitor:DP-2"
    "8,monitor:DVI-D-1"
    "9,monitor:DVI-D-1"
  ];
  home.packages = with pkgs; [
    grub2
  ];
}
