{
  flake.modules.homeManager.battery =
    {
      osConfig,
      config,
      lib,
      ...
    }:
    {
      options.battery.enable = lib.mkEnableOption "Enable battery script";

      config = lib.mkIf config.battery.enable {
        home.file.".config/hypr/battery.sh" = {
          enable = true;
          text = builtins.readFile ./battery.sh;
          executable = true;
        };
        my.autostart = [
          "/home/${osConfig.user.defaultUser}/.config/hypr/battery.sh"
        ];
      };
    };
}
