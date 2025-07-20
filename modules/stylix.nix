# Wallpapers home/wall.jpg
# Anders Jildén - https://unsplash.com/photos/grey-full-suspension-bridge-photography-during-daytime-AkUR27wtaxs

{
  pkgs,
  config,
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

  home-manager.users.${config.user.defaultUser}.stylix.targets = {
    firefox.profileNames = [ "default" ];
  };
}
