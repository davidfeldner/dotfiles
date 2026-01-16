{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    pear-desktop
    nextcloud-client
    vesktop
    protonvpn-gui
    pavucontrol
    scrcpy
    ungoogled-chromium
    mpv
    prusa-slicer
    protonvpn-gui
    rquickshare
  ];
}
