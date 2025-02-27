# Wallpapers home/wall.jpg
# Anders Jildén - https://unsplash.com/photos/grey-full-suspension-bridge-photography-during-daytime-AkUR27wtaxs

{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  stylix.enable = true;
  stylix.image = ./wall.jpg;
  stylix.polarity = "dark";

  stylix.base16Scheme = "${inputs.base16-rosepine}/rose-pine.yaml";

  # stylix.targets.waybar.enable = false;
  # stylix.targets.waybar.enableCenterBackColors = false;
  # stylix.targets.waybar.enableLeftBackColors = false;
  # stylix.targets.waybar.enableRightBackColors = false;
  stylix.targets.neovim.enable = false;
  stylix.targets.kitty.enable = true;
  stylix.targets.hyprland.enable = false;
  stylix.targets.vscode.enable = true;
}
