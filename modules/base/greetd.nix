{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "david";
      };
      default_session = initial_session;
    };
  };
}
