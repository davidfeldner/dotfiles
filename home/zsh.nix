{ lib, config, ... }:

let
  cfg = config.zsh;
in
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh";
    zsh.dualboot = lib.mkEnableOption "Enables grub aliases";
  };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        nxupdate = "sudo nixos-rebuild switch --flake ~/nixos/";
        nxtest = "sudo nixos-rebuild test --flake ~/nixos/";
        homelog = "journalctl -xe --unit home-manager-david";
        icat = "kitten icat";
        lofi = "mpv --no-video 'https://www.youtube.com/watch?v=jfKfPfyJRdk'";
        tvOff = "hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), disable";
        tvOn = "hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), 3840x2160@60, 0x0, 2";
        tvOnly = "tvOn && hyprctl monitors all | grep -i monitor | grep -Evi 'HDMI|Unknown' | awk '{print $2}' | while read -r mon; do hyprctl keyword monitor \"$mon,disable\"; done";
        tvReset = "tvOff && hyprctl keyword monitor DP-2,2560x1440@144,1920x0,1,vrr,1 && hyprctl keyword monitor DVI-D-1,1440x900,4480x0,1";
        code = "codium";
        dc = "docker compose";
      };

      initContent = ''
        function nxrun() {
          nix run "nixpkgs#$@"
        }

        function shellpy() {
          nix develop --impure --expr "let
            pkgs = import <nixpkgs> {};
            in pkgs.mkShell {
              packages = [
                (pkgs.python3.withPackages (ps: with ps; [
                  $*
                ]))
              ];
            }" -c $SHELL
        }

        function pkgs() {
          nix develop --impure --expr "let
            pkgs = import <nixpkgs> {};
            in pkgs.mkShell {
              packages = with pkgs; [
                  $*
              ];
            }" -c $SHELL
        }
      '';

      shellAliases.windows = lib.mkIf cfg.dualboot "sudo grub-reboot 1 && reboot";

      sessionVariables = {
        PATH = "$PATH:/home/david/.dotnet/tools";
        DOTNET_CLI_TELEMETRY_OPTOUT = 1;
      };
      #history = {
      #  size = 10000;
      #  path = "${config.xdg.dataHome}/zsh/history";
      #};
      oh-my-zsh = {
        enable = true;
        plugins = [ ];
      };
    };
  };
}
