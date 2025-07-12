# Wallpapers home/wall.jpg
# Anders Jildén - https://unsplash.com/photos/grey-full-suspension-bridge-photography-during-daytime-AkUR27wtaxs

{
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    image = ../home/wall.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    targets.grub.enable = false;
  };

  home-manager.users.david.stylix.targets = {
    neovim.enable = false;
    kitty.enable = true;
    hyprland.enable = false;
    hyprlock.enable = false;
    vscode.enable = true;
    mako.enable = false;
    firefox.profileNames = [ "default" ];
  };
}
