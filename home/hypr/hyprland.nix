{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.hyprland;
in
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ../walker.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
    hyprland.extraMonitorSettings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Aditional monitor arguments for hyprland";
    };
    hyprland.nvidia = lib.mkEnableOption "Enable NVIDIA settings";
    hyprland.extraWorkspaceSettings = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Aditional workspace arguments for hyprland";
    };
    hyprland.hidpi = lib.mkEnableOption "Enable high dpi 2x scaling";

  };

  config = lib.mkIf cfg.enable {
    home.file.".config/hypr/battery.sh" = {
      enable = true;
      text = builtins.readFile ./battery.sh;
    };
    home.packages = with pkgs; [
      hyprpicker
      xdg-utils
      sway-audio-idle-inhibit
      grimblast
      wl-clipboard
      brightnessctl
      kitty
      swayosd
      moreutils
      # walker
      libqalculate
    ];
    services.cliphist.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [ pkgs.hyprlandPlugins.hyprexpo ];
      settings = (
        lib.mkMerge [
          (lib.mkIf cfg.nvidia {
            env = [
              "LIBVA_DRIVER_NAME,nvidia"
              "XDG_SESSION_TYPE,wayland"
              "GBM_BACKEND,nvidia-drm"
              "__GLX_VEDOR_LIBRARY_NAME,nvidia"
              "NVD_BACKEND,direct"
              "GDK_BACKEND,wayland,x11"
              "SDL_VIDEODRIVER,wayland"
            ];
            cursor.no_hardware_cursors = true;
          })
          { workspace = [ ] ++ cfg.extraWorkspaceSettings; }
          {
            # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
            # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
            monitor = [ ",preferred,auto,1" ] ++ cfg.extraMonitorSettings;

            # █▀▀ ▀▄▀ █▀▀ █▀▀
            # ██▄ █░█ ██▄ █▄▄
            exec-once = [
              "waybar"
              # "hyprpaper"
              # "swww-daemon"
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "/usr/lib/polkit-kde-authentication-agent-1"
              #"hypridle"
              "libinput-gestures-setup start"
              # "dunst"
              #"/home/david/.config/hypr/battery.sh"
              "sway-audio-idle-inhibit"
              "wl-paste --watch cliphist --max-items 25 store"
              "swayosd-server"
              "ags"
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
              gaps_out = 5;
              border_size = 1;
              gaps_workspaces = 50;
              # "col.active_border" = "rgba(22aaaaaa)";
              # "col.inactive_border" = "0xff382D2E";
              layout = "dwindle";
              "col.active_border" = lib.mkDefault "rgba(F7DCDE39)";
              "col.inactive_border" = lib.mkDefault "rgba(A58A8D30)";
            };

            # █▀▄▀█ █ █▀ █▀▀
            # █░▀░█ █ ▄█ █▄▄
            misc = {
              background_color = lib.mkDefault "rgba(1D1011FF)";
              new_window_takes_over_fullscreen = 2;

              disable_hyprland_logo = true;
              mouse_move_enables_dpms = true;
              vfr = true;
              focus_on_activate = true;
            };

            # █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
            # █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
            decoration = {
              rounding = 20;

              blur = {
                enabled = true;
                xray = true;
                special = false;
                new_optimizations = true;
                size = 14;
                passes = 4;
                brightness = 1;
                noise = 1.0e-2;
                contrast = 1;
                popups = true;
                popups_ignorealpha = 0.6;
              };

              # Dim
              dim_inactive = false;
              dim_strength = 0.1;
              dim_special = 0;
            };

            animations = {
              enabled = true;
              # Animation curves

              bezier = [
                "linear, 0, 0, 1, 1"
                "md3_standard, 0.2, 0, 0, 1"
                "md3_decel, 0.05, 0.7, 0.1, 1"
                "md3_accel, 0.3, 0, 0.8, 0.15"
                "overshot, 0.05, 0.9, 0.1, 1.1"
                "crazyshot, 0.1, 1.5, 0.76, 0.92 "
                "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                "menu_decel, 0.1, 1, 0, 1"
                "menu_accel, 0.38, 0.04, 1, 0.07"
                "easeInOutCirc, 0.85, 0, 0.15, 1"
                "easeOutCirc, 0, 0.55, 0.45, 1"
                "easeOutExpo, 0.16, 1, 0.3, 1"
                "softAcDecel, 0.26, 0.26, 0.15, 1"
                "md2, 0.4, 0, 0.2, 1" # use with .2s duration
              ];
              # Animation configs
              animation = [
                "windows, 1, 3, md3_decel, popin 60%"
                "windowsIn, 1, 3, md3_decel, popin 60%"
                "windowsOut, 1, 3, md3_accel, popin 60%"
                "border, 1, 10, default"
                "fade, 1, 3, md3_decel"
                "layers, 1, 2, md3_decel, slide"
                "layersIn, 1, 3, menu_decel, slide"
                "layersOut, 1, 1.6, menu_accel"
                "fadeLayersIn, 1, 2, menu_decel"
                "fadeLayersOut, 1, 4.5, menu_accel"
                "workspaces, 1, 7, menu_decel, slide"
                # workspaces, 1, 2.5, softAcDecel, slide";
                #workspaces, 1, 7, menu_decel, slidefade 15%";
                #specialWorkspace, 1, 3, md3_decel, slidefadevert 15%";
                "specialWorkspace, 1, 3, md3_decel, slidevert"
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
              # Center dialogs
              "center, title:^(Open File)(.*)$"
              "center, title:^(Select a File)(.*)$"
              "center, title:^(Choose wallpaper)(.*)$"
              "center, title:^(Open Folder)(.*)$"
              "center, title:^(Save As)(.*)$"
              "center, title:^(Library)(.*)$"
              "center, title:^(File Upload)(.*)$"
              "float,title:^(Open File)(.*)$"
              "float,title:^(Select a File)(.*)$"
              "float,title:^(Choose wallpaper)(.*)$"
              "float,title:^(Open Folder)(.*)$"
              "float,title:^(Save As)(.*)$"
              "float,title:^(Library)(.*)$"
              "float,title:^(File Upload)(.*)$"

            ];

            windowrulev2 = [
              "noinitialfocus,class:^jetbrains-(?!toolbox),floating:1"
              # Window workpace position
              "workspace 1, class:^firefox"
              "workspace 4, class:^GitHub Desktop"
              "workspace 5, class:^VencordDesktop"
              "workspace 6, class:^virt-manager"

              "noshadow,floating:0"

            ];

            layerrule = [
              "xray 1, .*"
              "noanim, walker"
              "noanim, selection"
              "noanim, overview"
              "noanim, anyrun"
              "noanim, indicator.*"
              "noanim, osk"
              "noanim, hyprpicker"
              "blur, shell:*"
              "ignorealpha 0.6, shell:*"
              "noanim, noanim"
              "blur, gtk-layer-shell"
              "ignorezero, gtk-layer-shell"
              "blur, launcher"
              "ignorealpha 0.5, launcher"
              "blur, notifications"
              "ignorealpha 0.69, notifications"
              "animation slide top, sideleft.*"
              "animation slide top, sideright.*"
              "blur, session"
              "blur, bar"
              "ignorealpha 0.6, bar"
              "blur, corner.*"
              "ignorealpha 0.6, corner.*"
              "blur, dock"
              "ignorealpha 0.6, dock"
              "blur, indicator.*"
              "ignorealpha 0.6, indicator.*"
              "blur, overview"
              "ignorealpha 0.6, overview"
              "blur, cheatsheet"
              "ignorealpha 0.6, cheatsheet"
              "blur, sideright"
              "ignorealpha 0.6, sideright"
              "blur, sideleft"
              "ignorealpha 0.6, sideleft"
              "blur, indicator*"
              "ignorealpha 0.6, indicator*"
              "blur, osk"
              "ignorealpha 0.6, osk"
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
              "$mainMod SHIFT, F, fullscreenstate, -1, 2"
              "$mainMod, R, exec, walker"
              "$mainMod, period, exec, walker -m emojis"
              "$mainMod, S, pseudo, # dwindle"
              "$mainMod, J, togglesplit, # dwindle"
              "$mainMod, L, exec, hyprlock"
              "$mainMod, H, exec, cliphist list | walker -d -k | cliphist decode | ifne wl-copy"
              "$mainMod SHIFT, H, exec, cliphist list | walker -d -k | cliphist delete"
              "$mainMod SHIFT CTRL, H, exec, cliphist wipe"
              #"$mainMod SHIFT, P, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

              "$mainMod SHIFT, Z, exec, systemctl suspend"

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
            bindl = [
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;ags run-js 'indicator.popup(1)'"
            ];
            bindle = [
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+;ags run-js 'indicator.popup(1)'"
              ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-;ags run-js 'indicator.popup(1)'"

              # ", XF86MonBrightnessDown, exec, ags run-js 'brightness.screen_value -= 0.05;indicator.popup(1);'"
              # ", XF86MonBrightnessDown, exec, ags run-js 'brightness.screen_value -= 0.05;indicator.popup(1);'"
              ", XF86MonBrightnessDown,   exec, brightnessctl set 5%-"
              ", XF86MonBrightnessUp,     exec, brightnessctl set 5%+"
            ];
          }
          (lib.mkIf cfg.hidpi {
            xwayland = {
              force_zero_scaling = true;
            };
            # toolkit-specific scale
            env = [
              "GDK_SCALE,2"
              "XCURSOR_SIZE,24"
            ];

          })
        ]
      );
    };
  };
}
