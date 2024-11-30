{ lib, ... }:
{
  stylix.enable = true;
  stylix.image = ./wall.jpg;
  stylix.polarity = "dark";
  # stylix.targets.waybar.enable = false;
  # stylix.targets.waybar.enableCenterBackColors = false;
  # stylix.targets.waybar.enableLeftBackColors = false;
  # stylix.targets.waybar.enableRightBackColors = false;
  stylix.targets.neovim.enable = false;
  stylix.targets.kitty.enable = false;
  stylix.targets.hyprland.enable = false;
}
