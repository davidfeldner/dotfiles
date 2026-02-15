{ ... }:
{
  flake.modules.homeManager.hyprpaper =
    { ... }:
    {
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          # splash_offset = 2.0;

          preload = [
            "~/nixos/assets/wall.jpg"
          ];

          wallpaper = [
            ",~/nixos/assets/wall.jpg"
          ];
        };
      };
    };
}
