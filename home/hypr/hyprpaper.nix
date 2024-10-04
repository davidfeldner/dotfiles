{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "~/nixos/home/wall.jpg"
      ];

      wallpaper = [
        ",~/nixos/home/wall.jpg"
      ];
    };
  };
}
