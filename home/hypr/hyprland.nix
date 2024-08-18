{ ... }:

{
  enable = true;
  settings = {
      # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
      # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
      monitor = [
        "eDP-1,3072x1920@120,0x0,2"
        ",preferred,auto,1"
      ];

      # █▀▀ ▀▄▀ █▀▀ █▀▀
      # ██▄ █░█ ██▄ █▄▄
      exec-once = [
        "waybar"
       # "hyprpaper"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "/usr/lib/polkit-kde-authentication-agent-1"
        #"hypridle"
        "libinput-gestures-setup start"
        "dunst"
        "/home/david/.config/hypr/battery.sh"
        "sway-audio-idle-inhibit"
        "wl-paste --watch cliphist --max-items 25 store"
        "swayosd-server"
      ];

      # █ █▄░█ █▀█ █░█ ▀█▀
      # █ █░▀█ █▀▀ █▄█ ░█░
      input = {
          kb_layout = "us,dk";
          kb_options = "grp:alt_shift_toggle,caps:escape";
          repeat_rate = 40;
          repeat_delay = 400;
          follow_mouse = 1;
          touchpad = {
              natural_scroll = true;
              scroll_factor = 0.5;
          };
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      # █▀▀ █▀▀ █▄░█ █▀▀ █▀█ ▄▀█ █░░
      # █▄█ ██▄ █░▀█ ██▄ █▀▄ █▀█ █▄▄
      general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          gaps_in = 4;
          gaps_out = 6;
          border_size = 2;
          "col.active_border"="rgba(22aaaaaa)";
          "col.inactive_border"="0xff382D2E";
          layout = "dwindle";
      };

      # █▀▄▀█ █ █▀ █▀▀
      # █░▀░█ █ ▄█ █▄▄
      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        vfr = true;
        focus_on_activate = true;
      };

      # █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
      decoration = {
          rounding = 10;
          drop_shadow = true;
          shadow_range = 4;
      };

      animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
      };

      dwindle = {
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
      };


      gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true;
          workspace_swipe_fingers = 4;
          workspace_swipe_distance = 200;
          workspace_swipe_cancel_ratio = 0.4;
      };

      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
      windowrule = [
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, Lxappearance"
        "float, Rofi"
        "animation none,Rofi"
        "float, viewnior"
        "float, Viewnior"
        "float, feh"
        "float, file-roller"
        "float, title:DevTools"
        "fullscreen, wlogout"
        "float, title:wlogout"
        "fullscreen, title:wlogout"
        "idleinhibit focus, mpv"
        "idleinhibit fullscreen, brave"
        "float, title:^(Media viewer)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "size 800 600, title:^(Volume Control)$"
        "move 75 44%, title:^(Volume Control)$"
        "opacity 0.92, Dolphin"
      ];

      windowrulev2 = [
        "noinitialfocus,class:^jetbrains-(?!toolbox),floating:1"
        # Window workpace position
        "workspace 1, class:^firefox"
        "workspace 4, class:^GitHub Desktop"
        "workspace 5, class:^VencordDesktop"
        "workspace 6, class:^virt-manager"
      ];

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mainMod" = "SUPER";

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mainMod, T, exec, kitty"
        "$mainMod ALT, T, exec, [float; size 50%] kitty "
        "$mainMod, Q, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, E, exec, dolphin"
        "$mainMod ALT, E, exec,[float;size 50%] dolphin"
        "$mainMod, B, exec, firefox"
        "$mainMod, C, exec, code"
        "$mainMod, Y, exec, freetube"
        "$mainMod, D, exec, vesktop --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"
        "$mainMod, A, exec, /home/david/.config/hypr/runVM.sh archlinux"
        "$mainMod, K, exec, /home/david/.config/hypr/runVM.sh Kali"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pin"
        "$mainMod, F, fullscreen "
        #"$mainMod SHIFT, F, fakefullscreen"
        "$mainMod, R, exec, rofi -show drun -run-shell-command '{terminal} -e zsh -ic \"{cmd} && read\"'"
        "$mainMod, period, exec, rofi -show emoji"
        "$mainMod, S, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, H, exec, cliphist list | rofi -dmenu | cliphist decode | ifne wl-copy"
        "$mainMod SHIFT, H, exec, cliphist list | rofi -dmenu | cliphist delete"
        "$mainMod SHIFT CTRL, H, exec, cliphist wipe "
        "$mainMod SHIFT, P, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        #SCREEN
        "$mainMod SHIFT, e, exec, hyprctl keyword monitor ,prefered,auto,1"
        "$mainMod SHIFT, d, exec, hyprctl keyword monitor ,prefered,auto,1,mirror,eDP-1"

        # ÆØÅ
        #bind = $mainMod, code:47, exec, echo "Æ" | 

        #screen rotate
        "$mainMod SHIFT, R, exec, hyprctl keyword monitor eDP-1,3072x1920@120,auto,2,transform,0"
        "$mainMod SHIFT, T, exec, hyprctl keyword monitor eDP-1,3072x1920@120,auto,2,transform,1"

        #bind=$mainMod,minus,submap,clean
        #submap=clean
        #bind=$mainMod,minus,submap,reset
        #submap=reset


        # █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
        # ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░
        "SUPER SHIFT, S, exec, grimblast --notify copy area"
        ", Print, exec, grimblast --notify --cursor copy output"
        "ALT, Print, exec, grimblast --notify --cursor copy screen"
        #color picker
        "$mainMod SHIFT, C, exec, hyprpicker -a"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # move with arrow keys
        "$mainMod CTRL, right, workspace, e+1"
        "$mainMod CTRL, left, workspace, e-1"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move active window to a workspace SILENTLY with mainMod + SHIFT + CTRL + [0-9]
        "$mainMod CTRL SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod CTRL SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod CTRL SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod CTRL SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod CTRL SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod CTRL SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod CTRL SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod CTRL SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod CTRL SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod CTRL SHIFT, 0, movetoworkspacesilent, 10"

        # Move active window between workspaces with mainMod + SHIFT + left/right arrow
        "$mainMod SHIFT, right, movetoworkspace, r+1"
        "$mainMod SHIFT, left, movetoworkspace, r-1"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "ALT, mouse:272, resizewindow"
      ];


      # Function keys
      #bind =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
      #bind =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
      #bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ];
      bindle = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        
        ", XF86MonBrightnessDown,   exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp,     exec, brightnessctl set 10%+"
      ];
      #bind = , XF86MonBrightnessDown,   exec, swayosd-client --brightness raise
      #bind = , XF86MonBrightnessUp,     exec, swayosd-client --brightness lower

      xwayland = {
        force_zero_scaling = true;
      };
      # toolkit-specific scale
      env = [
        "GDK_SCALE,2"
        "XCURSOR_SIZE,24"
      ];
  };
}
