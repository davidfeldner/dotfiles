{
  flake.modules.homeManager.fish =
    {
      lib,
      pkgs,
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
      config.programs = {
        starship = {
          enable = true;
          enableFishIntegration = true;
        };

        kitty.shellIntegration.enableFishIntegration = true;
        # programs.zellij.enableFishIntegration = true;

        fish = {
          enable = true;
          shellInit = ''
            set -g fish_greeting ""

            set -g fish_color_autosuggestion ${
              if (builtins.hasAttr "stylix" config) then config.lib.stylix.colors.base0B else "555555"
            };

            if status is-interactive; and test -z "$TMUX"
              tmux new-session -t 0
            end

            export PATH="$PATH:/home/david/.npm-global/bin/"
          '';
          binds = {
            "alt-backspace".command = "backward-kill-bigword";
          };
          shellAliases = {
            ll = "ls -l";
            nxupdate = "sudo nixos-rebuild switch --flake ~/nixos/";
            nomupdate = "sudo -v && sudo nixos-rebuild switch --flake ~/nixos/ --log-format internal-json -v |& ${lib.getExe pkgs.nix-output-monitor} --json";
            nxtest = "sudo nixos-rebuild test --flake ~/nixos/";
            nomtest = "sudo -v && sudo nixos-rebuild test --flake ~/nixos/ --log-format internal-json -v |& ${lib.getExe pkgs.nix-output-monitor} --json";
            homelog = "journalctl -xe --unit home-manager-${osConfig.user.defaultUser}";
            icat = "kitten icat";
            lofi = "mpv --no-video 'https://www.youtube.com/watch?v=jfKfPfyJRdk'";
            code = "codium";
            dc = "docker compose";
            setLenovoBatterySaver = "echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";
            get = "${lib.getExe pkgs.yt-dlp}";
          };

          shellAliases.windows = lib.mkIf cfg.dualboot "sudo grub-reboot 1 && reboot";

          functions = {
            stream = ''
              ${lib.getExe pkgs.yt-dlp} --force-overwrites -o /tmp/yt-dlp-stream $argv && mpv /tmp/yt-dlp-stream*
            '';
            nxrun = ''
              set pkg $argv[1]
              set args $argv[2..-1]
              nix run nixpkgs#$pkg -- $args
            '';
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
              hyprctl monitors all | grep -A20 '^Monitor HDMI' | grep description | cut -d: -f2-
            '';
            direnvinit.body = ''
              if test (count $argv) -eq 0
                echo "Usage: direnvinit <dir>"
                return 1
              end

              set arg $argv[1]

              echo "use flake \"github:davidfeldner/dotfiles?dir=$arg\"" > .envrc
              direnv allow
            '';
            tvOn.body = ''
              hyprctl eval "hl.monitor({
                  output = \"desc:$(tvmon)\",
                  disabled = false,
                  mode = \"3840x2160@60\",
                  position = \"0x0\",
                  scale = 2
              })"
            '';

            tvOff.body = ''
              hyprctl eval "hl.monitor({
                  output = \"desc:$(tvmon)\",
                  disabled = true
              })"
            '';

            tvOnly.body = ''
              tvOn
              for mon in (hyprctl monitors all | grep -i monitor | grep -Evi 'HDMI|Unknown' | awk '{print $2}')
                hyprctl eval "hl.monitor({
                  output = \"$mon\",
                  disabled = true
                })"
              end
            '';

            tvReset.body = ''
              tvOff
              for mon in (hyprctl monitors all | grep -i monitor | grep -Evi 'HDMI|Unknown' | awk '{print $2}')
                hyprctl eval "hl.monitor({
                  output = \"$mon\",
                  disabled = false
                })"
              end
            '';
          };
        };
      };
    };
}
