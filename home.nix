{ pkgs, ... }:

{
  imports = [
    ./home/dunst.nix
    ./home/test.nix
    ./home/hypr/hyprland.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      LazyVim
      onedark-nvim
    ];
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  programs.firefox = import ./home/firefox.nix { inherit pkgs; };

  programs.waybar = import ./home/waybar.nix { };

  programs.git = {
    enable = true;
    userName = "davidfeldner";
    userEmail = "davidfeldner12@gmail.com";
  };

  hyprland.enable = true;
  programs.zsh = import ./home/zsh.nix { inherit pkgs; };

  #  home.packages = with pkgs; [
  #
  # ];

  home.stateVersion = "24.05";
}
