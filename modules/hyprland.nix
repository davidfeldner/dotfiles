{ pkgs, ... }:
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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "david";
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];
}
