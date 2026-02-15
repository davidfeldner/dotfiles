{ self, ... }:
{
  flake.modules.homeManager.general = {
    imports = with self.modules.homeManager; [
      hyprland
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
      zsh
      yazi
    ];

    home.stateVersion = "24.05";
  };
}
