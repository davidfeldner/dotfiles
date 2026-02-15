# Wallpapers assets/wall.jpg
# Michael Hacker - https://unsplash.com/photos/snow-covered-pine-tree-in-mountain-under-cloudy-sky-OoQKL4cLZuc

{ ... }:
{
  flake.nixosModules.stylix =
    {
      inputs,
      pkgs,
      config,
      ...
    }:
    {
      stylix = {
        enable = true;
        image = inputs.self + "/assets/wall.jpg";
        polarity = "dark";
        # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nova.yaml";
        targets.grub.enable = false;
      };

      home-manager.users.${config.my.user}.stylix = {
        targets.firefox.profileNames = [ "default" ];
      };
    };
}
