{ ... }:
{
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
      homelog = "journalctl -xe --unit home-manager-david";
      icat = "kitten icat";
      lofi = "mpv --no-video 'https://www.youtube.com/watch?v=jfKfPfyJRdk'";
      tvOff = " hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), disable";
      tvOn = " hyprctl keyword monitor $(hyprctl monitors all | grep 'HDMI'| awk '{print $2}' | head -n 1), 3840x2160@60, 0x0, 2";
      code = "codium";
      dc = "docker compose";
    };
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
    };
  };
}
