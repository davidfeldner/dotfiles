{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    freetube
    youtube-music
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
