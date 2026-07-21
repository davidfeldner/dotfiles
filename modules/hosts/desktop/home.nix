{ self, ... }:
{
  flake.modules.homeManager.desktopHome =
    { pkgs, ... }:
    {
      imports = [
        self.modules.homeManager.general
        self.modules.homeManager.mangohud
      ];
      hyprland.extraMonitorSettings =
        let
          disable = output: {
            inherit output;
            disabled = true;
          };
        in
        [
          {
            output = "DP-1";
            mode = "1440x900";
            position = "4480x0";
            scale = "1";
          }
          {
            output = "DP-2";
            mode = "2560x1440@144";
            position = "1920x0";
            scale = "1";
            vrr = 1;
          }

          (disable "HDMI-A-1")
          (disable "HDMI-A-2")
          (disable "HDMI-A-3")
          (disable "HDMI-A-4")
          (disable "HDMI-A-5")
          (disable "HDMI-A-6")
          (disable "Unknown-1")
        ];
      hyprland.extraWorkspaceRules = [
        {
          workspace = "1";
          monitor = "DP-2";
          default = true;
        }
        {
          workspace = "8";
          monitor = "DP-1";
          default = true;
        }
        {
          workspace = "9";
          monitor = "DP-1";
        }
      ];
      home.packages = with pkgs; [
        grub2
      ];
      zsh.dualboot = true;
      fish.dualboot = true;
    };
}
