{ config, pkgs, ... }:

{
  programs.neovim =  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [ LazyVim onedark-nvim ];
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
  
	programs.firefox = import ./home/firefox.nix { inherit pkgs; };

  programs.waybar = import ./home/waybar.nix {};

  programs.git = {
    enable = true;
    userName  = "davidfeldner";
    userEmail = "davidfeldner12@gmail.com";
  };



  wayland.windowManager.hyprland = import ./home/hypr/hyprland.nix {};
  programs.hyprlock = import ./home/hypr/hyprlock.nix {};
  home.file.".config/hypr/battery.sh" = {
    enable = true;
    text = builtins.readFile ./home/hypr/battery.sh;
  };
  services.hypridle = import ./home/hypr/hypridle.nix {};

  programs.zsh = import ./home/zsh.nix { inherit pkgs; };

  home.packages = with pkgs; [

  ];

  home.stateVersion = "24.05";
}
