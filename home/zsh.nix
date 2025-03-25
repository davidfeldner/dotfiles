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
        tvOff = " hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), disable";
        tvOn = " hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), 3840x2160@60, 0x0, 2";
        code = "codium";
        dc = "docker compose";
      };

      initExtra = ''
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
