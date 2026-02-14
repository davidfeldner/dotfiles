{ self, ... }:
{
  flake.modules.homeManager.general = {
    imports = with self.modules.homeManager; [
      dunst
      hyprland
      waybar
      ssh
      tmux
      zellij
      zoxide
      dotnet
      dev-basic
      vscode
      zed
      dev-cli
      gui-tools
      nvim
      fish
      git
      itu-vpn
      firefox
      freetube
      hypridle
      hyprlock
      hyprpaper
      walker

    ];

    hyprland.enable = true;
    #zsh.enable = true;

    home.stateVersion = "24.05";
  };
}
