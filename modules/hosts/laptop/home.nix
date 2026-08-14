{ self, ... }:
{
  flake.modules.homeManager.laptopHome = {
    imports = with self.modules.homeManager; [
      hyprland
      ssh
      tmux
      zoxide
      dotnet
      dev-basic
      vscode
      dev-cli
      gui-tools
      nvim
      fish
      git
      firefox
      freetube
      zsh
      yazi
      labwc
      opencode
      codex
      safeeyes
      battery
    ];
    hyprland.extraMonitorSettings = [
      {
        output = "eDP-1";
        mode = "3072x1920@60";
        position = "0x0";
        scale = "2";
      }
    ];
    hyprland.hidpi = true;

    home.stateVersion = "24.05";
  };
}
