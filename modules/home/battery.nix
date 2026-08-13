{
  flake.modules.homeManager.battery =
    {
      osConfig,
      config,
      lib,
      ...
    }:
    {
      config = {
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
