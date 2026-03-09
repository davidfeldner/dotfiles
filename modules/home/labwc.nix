_: {
  flake.modules.homeManager.labwc =
    { pkgs, ... }:
    {
      wayland.windowManager.labwc = {
        enable = true;
        autostart = [ "~/.config/labwc/clipboard.sh" ];
      };
      home.file.".config/labwc/clipboard.sh" = {
        executable = true;
        text = ''
          #!/bin/bash
          NESTED="$WAYLAND_DISPLAY"
          MAIN=$(hyprctl -j instances | jq -r '.[0].wl_socket')

          cleanup() {
            kill 0
            exit
          }
          trap cleanup EXIT INT TERM

          ( while pgrep -x labwc > /dev/null; do sleep 1; done; kill 0 ) &


          LAST_SYNCED=$(mktemp)

          WAYLAND_DISPLAY=$MAIN wl-paste --watch bash -c "
            NEW=\$(WAYLAND_DISPLAY=$MAIN wl-paste 2>/dev/null)
            LAST=\$(cat $LAST_SYNCED)
            if [ -n \"\$NEW\" ] && [ \"\$NEW\" != \"\$LAST\" ]; then
              echo -n \"\$NEW\" | WAYLAND_DISPLAY=$NESTED wl-copy
              echo -n \"\$NEW\" > $LAST_SYNCED
            fi
          " &

          WAYLAND_DISPLAY=$NESTED wl-paste --watch bash -c "
            NEW=\$(WAYLAND_DISPLAY=$NESTED wl-paste 2>/dev/null)
            LAST=\$(cat $LAST_SYNCED)
            if [ -n \"\$NEW\" ] && [ \"\$NEW\" != \"\$LAST\" ]; then
              echo -n \"\$NEW\" | WAYLAND_DISPLAY=$MAIN wl-copy
              echo -n \"\$NEW\" > $LAST_SYNCED
            fi
          " &

          wait
          rm -f "$LAST_SYNCED"
        '';
      };
      home.packages = [ pkgs.jq ];
      programs.fish.shellAliases = {
        stack = "labwc -s";
      };
    };
}
