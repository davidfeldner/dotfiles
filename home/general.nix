{
  pkgs,
  ...
}:
{
  imports = [
    #./cachix.nix
    ./dunst.nix
    ./test.nix
    ./hypr/hyprland.nix
    ./waybar.nix
    #./ags.nix
    #./anyrun.nix
    #./fuzzel.nix
    ./ssh.nix
    # ./theme.nix
    ./tmux.nix
    ./dev/dotnet.nix
    ./dev/basic.nix
    ./dev/vscode.nix
    ./dev/cli-tools.nix
    ./gui-tools.nix
    #./nvim.nix
    ./zsh.nix
    ./git.nix
    ./stylix.nix
    ./ituvpn.nix
  ];
  programs.kitty.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # LazyVim
      onedark-nvim
    ];
  };
  programs.wofi.enable = true;

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  programs.firefox = import ./firefox.nix { inherit pkgs; };

  hyprland.enable = true;
  zsh.enable = true;
  #  home.packages = with pkgs; [
  #
  # ];

  home.stateVersion = "24.05";
}
