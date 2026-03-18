# Wallpapers assets/wall.jpg
# Digital Buggu - https://www.pexels.com/photo/close-up-photo-of-orange-and-yellow-gazania-flowers-165925/

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
        image = builtins.path {
          path = inputs.self + "/assets/wall.jpg";
          name = "wall.jpg";
        };
        polarity = "dark";
        # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
        targets.grub.enable = false;
      };

      home-manager.users.${config.my.user}.stylix = {
        targets.firefox.profileNames = [ "default" ];
      };
    };
}
