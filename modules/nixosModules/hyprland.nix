{
  flake.modules.nixos.hyprland =
    { pkgs, config, ... }:
    {
      services = {
        speechd.enable = false;

        hypridle.enable = true;

        gnome.gnome-keyring.enable = true;

        greetd = {
          enable = true;
          settings = rec {
            initial_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/start-hyprland";
              user = config.user.defaultUser;
            };
            default_session = initial_session;
          };
        };
      };

      programs = {
        hyprland.enable = true;
        hyprlock.enable = true;
      };

      environment.systemPackages = with pkgs; [
        firefox
      ];

      environment.sessionVariables = {
        XDG_DOWNLOAD_DIR = "$HOME/downloads";
      };
    };
}
