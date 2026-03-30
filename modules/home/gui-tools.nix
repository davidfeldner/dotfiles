_: {
  flake.modules.homeManager.gui-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian
        pear-desktop
        nextcloud-client
        vesktop
        proton-vpn
        pavucontrol
        scrcpy
        ungoogled-chromium
        mpv
        prusa-slicer
        rquickshare
        arduino-ide
        eclipses.eclipse-modeling
      ];
    };
}
