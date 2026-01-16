{ pkgs, config, ... }:
{
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
  };

  services.hypridle.enable = true;

  services.gnome.gnome-keyring.enable = true;

  programs.kdeconnect.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/start-hyprland";
        user = config.user.defaultUser;
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];
}
