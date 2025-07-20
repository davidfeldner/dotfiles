{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.fish;
in
{
  options = {
    fish.dualboot = lib.mkEnableOption "Enables grub aliases";
  };
  config = {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.kitty.shellIntegration.enableFishIntegration = true;
    programs.zellij.enableFishIntegration = true;

    programs.fish = {
      enable = true;
      shellInit = ''
        set -g fish_greeting ""
      '';
      shellAliases = {
        ll = "ls -l";
        nxupdate = "sudo nixos-rebuild switch --flake ~/nixos/";
        nxtest = "sudo nixos-rebuild test --flake ~/nixos/";
        homelog = "journalctl -xe --unit home-manager-${osConfig.user.defaultUser}";
        icat = "kitten icat";
        lofi = "mpv --no-video 'https://www.youtube.com/watch?v=jfKfPfyJRdk'";
        code = "codium";
        dc = "docker compose";
      };

      shellAliases.windows = lib.mkIf cfg.dualboot "sudo grub-reboot 1 && reboot";

      functions = {
        nxrun = ''nix run "nixpkgs#$argv"'';
        shellpy = ''
          nix develop --impure --expr "
                let
                  pkgs = import <nixpkgs> {};
                in pkgs.mkShell {
                  packages = [
                    (pkgs.python3.withPackages (ps: with ps; [
                      $argv
                    ]))
                  ];
                }" -c $SHELL'';
        pkgs = ''
          nix develop --impure --expr "
            let
              pkgs = import <nixpkgs> {};
            in pkgs.mkShell {
              packages = with pkgs; [
                $argv
              ];
            }" -c $SHELL'';
        tvmon.body = ''
          hyprctl monitors all | grep HDMI | awk '{print $2}' | head -n 1
        '';

        tvOn.body = ''
          hyprctl keyword monitor (tvmon),3840x2160@60,0x0,2
        '';

        tvOff.body = ''
          hyprctl keyword monitor (tvmon),disable
        '';

        tvOnly.body = ''
          tvOn
          for mon in (hyprctl monitors all | grep -i monitor | grep -Evi 'HDMI|Unknown' | awk '{print $2}')
            hyprctl keyword monitor "$mon,disable"
          end
        '';

        tvReset.body = ''
          tvOff
          hyprctl keyword monitor DP-2,2560x1440@144,1920x0,1,vrr,1
          hyprctl keyword monitor DVI-D-1,1440x900,4480x0,1
        '';
      };
    };
  };
}
