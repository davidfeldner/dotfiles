{ ... }:
{
  imports = [
    ./dunst.nix
    ./hypr/hyprland.nix
    ./waybar.nix
    ./ssh.nix
    ./tmux.nix
    ./zellij.nix
    ./zoxide.nix
    ./yazi.nix
    ./dev/dotnet.nix
    ./dev/basic.nix
    ./dev/vscode.nix
    ./dev/cli-tools.nix
    ./gui-tools.nix
    ./nvim.nix
    ./zsh.nix
    ./fish.nix
    ./git.nix
    ./ituvpn.nix
    ./firefox.nix
    ./freetube.nix
  ];

  hyprland.enable = true;
  zsh.enable = true;

  home.stateVersion = "24.05";
}
