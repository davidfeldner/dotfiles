{ self, ... }:
{
  flake.modules.homeManager.hyprland =
    {
      lib,
      config,
      pkgs,
      osConfig,
      ...
    }:

    let
      cfg = config.hyprland;
    in
    {
      imports = with self.modules.homeManager; [
        hypridle
        hyprlock
        hyprpaper
        hyprcursor
        walker
        waybar
        dunst
      ];
      options.my.autostart = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "list of exec's to autostart";
      };
      options.hyprland = {
        extraMonitorSettings = lib.mkOption {
          type = lib.types.listOf lib.types.attrs;
          default = [ ];
          description = "Aditional monitor arguments for hyprland";
        };
        extraWorkspaceRules = lib.mkOption {
          type = lib.types.listOf lib.types.attrs;
          default = [ ];
          description = "Aditional workspace rules for hyprland";
        };
        hidpi = lib.mkEnableOption "Enable high dpi 2x scaling";

      };

      config = {
        home.file.".config/hypr/battery.sh" = {
          enable = true;
          text = builtins.readFile ./battery.sh;
          executable = true;
        };
        home.packages = with pkgs; [
          hyprpicker
          xdg-utils
          sway-audio-idle-inhibit
          grimblast
          wl-clipboard
          brightnessctl
          moreutils
          libqalculate
          libnotify
          wofi
          adwaita-icon-theme
        ];
        programs.kitty = {
          enable = true;
          settings = {
            auto_reload_config = -1;
          };
        };
        services.cliphist = {
          enable = true;
          allowImages = true;
          extraOptions = [
            "-max-dedupe-search"
            "10"
            "-max-items"
            "30"
          ];
        };

        gtk = {
          enable = true;
          # gtk4.theme = config.gtk.theme;
          gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        };

        my.autostart = [
          "waybar"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "/usr/lib/polkit-kde-authentication-agent-1"
          "libinput-gestures-setup start"
          "/home/${osConfig.user.defaultUser}/.config/hypr/battery.sh"
          "sway-audio-idle-inhibit"
          "safeeyes"
          "elephant"
          "walker --gapplication-service"
          "kdeconnectd"
        ];

        wayland.windowManager.hyprland = {
          enable = true;
          configType = "lua";
          settings = lib.mkMerge [
            {
              mod = {
                _var = "SUPER";
              };

              workspace_rule = cfg.extraWorkspaceRules;

              monitor = [
                {
                  output = "";
                  mode = "preferred";
                  position = "auto";
                  scale = "auto";
                }
              ]
              ++ cfg.extraMonitorSettings;

              on._args = [
                "hyprland.start"
                (lib.generators.mkLuaInline ''
                  function()
                    ${
                      config.my.autostart
                      |> map (cmd: builtins.toJSON cmd)
                      |> lib.concatMapStringsSep "\n" (cmd: "hl.exec_cmd(${cmd})")
                    }
                  end
                '')
              ];

              config = {
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
                };

                general = {
                  gaps_in = 4;
                  gaps_out = 5;
                  border_size = 1;
                  gaps_workspaces = 50;
                  layout = "dwindle";
                  "col.active_border" = lib.mkDefault "rgba(F7DCDE39)";
                  "col.inactive_border" = lib.mkDefault "rgba(A58A8D30)";
                };

                misc = {
                  background_color = lib.mkDefault "rgba(1D1011FF)";
                  # new_window_takes_over_fullscreen = 2;

                  disable_hyprland_logo = true;
                  mouse_move_enables_dpms = true;
                  # vfr = true;
                  focus_on_activate = true;
                };

                decoration = {
                  rounding = 10;

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
                dwindle = {
                  preserve_split = true; # you probably want this
                };
                gestures = {
                  workspace_swipe_distance = 200;
                  workspace_swipe_cancel_ratio = 0.4;
                };
              };

              curve =
                let
                  curve = name: points: {
                    _args = [
                      name
                      {
                        type = "bezier";
                        inherit points;
                      }
                    ];
                  };
                in
                [
                  (curve "md3_decel" [
                    [
                      0.05
                      0.7
                    ]
                    [
                      0.1
                      1.0
                    ]
                  ])
                  (curve "md3_accel" [
                    [
                      0.3
                      0.0
                    ]
                    [
                      0.8
                      0.15
                    ]
                  ])
                  (curve "menu_decel" [
                    [
                      0.1
                      1.0
                    ]
                    [
                      0.0
                      1.0
                    ]
                  ])
                  (curve "menu_accel" [
                    [
                      0.38
                      0.04
                    ]
                    [
                      1.0
                      0.07
                    ]
                  ])
                ];
              animation =
                let
                  anim =
                    leaf: speed: bezier: style:
                    {
                      inherit leaf speed bezier;
                      enabled = true;
                    }
                    // lib.optionalAttrs (style != null) {
                      inherit style;
                    };
                in
                [
                  (anim "windows" 3 "md3_decel" "popin 60%")
                  (anim "windowsOut" 3 "md3_accel" "popin 60%")
                  (anim "border" 10 "default" null)
                  (anim "fade" 3 "md3_decel" null)
                  (anim "layers" 2 "md3_decel" "slide")
                  (anim "layersIn" 3 "menu_decel" "slide")
                  (anim "layersOut" 1.6 "menu_accel" null)
                  (anim "fadeLayersIn" 2 "menu_decel" null)
                  (anim "fadeLayersOut" 4.5 "menu_accel" null)
                  (anim "workspaces" 7 "menu_decel" "slide")
                  (anim "specialWorkspace" 3 "md3_decel" "slidevert")
                ];

              gesture = [
                {
                  fingers = 4;
                  direction = "horizontal";
                  action = "workspace";
                }
              ];

              window_rule = [
                {
                  match = {
                    class = "^VencordDesktop";
                  };
                  workspace = 5;
                }
                {
                  match = {
                    class = "^firefox";
                  };
                  workspace = 1;
                }
              ];

              bind =
                let
                  lua = lib.generators.mkLuaInline;

                  exec = command: lua "hl.dsp.exec_cmd(${builtins.toJSON command})";

                  modKey = key: lua "mod .. ${builtins.toJSON " + ${key}"}";

                  bind = key: action: {
                    _args = [
                      key
                      action
                    ];
                  };

                  bindWith = flags: key: action: {
                    _args = [
                      key
                      action
                      flags
                    ];
                  };

                  bindExec = key: command: bind key (exec command);

                  bindExecWith =
                    flags: key: command:
                    bindWith flags key (exec command);

                  # Common dispatcher helpers
                  closeWindow = lua "hl.dsp.window.close()";
                  toggleFloat = lua "hl.dsp.window.float()";
                  togglePin = lua "hl.dsp.window.pin()";
                  toggleFullscreen = lua "hl.dsp.window.fullscreen()";
                  togglePseudo = lua "hl.dsp.window.pseudo()";
                  toggleGroup = lua "hl.dsp.group.toggle()";
                  nextGroup = lua "hl.dsp.group.next()";

                  focusDirection = direction: lua "hl.dsp.focus({ direction = ${builtins.toJSON direction} })";

                  focusWorkspace = workspace: lua "hl.dsp.focus({ workspace = ${builtins.toJSON workspace} })";

                  moveWorkspace = workspace: lua "hl.dsp.window.move({ workspace = ${builtins.toJSON workspace} })";

                  moveWorkspaceSilent =
                    workspace:
                    lua ''
                      hl.dsp.window.move({
                        workspace = ${builtins.toJSON workspace},
                        follow = false
                      })
                    '';
                in
                [
                  # Applications
                  (bindExec (modKey "T") "kitty")

                  # exec_cmd supports window rules as its second Lua argument.
                  (bind (modKey "ALT + T") (lua ''
                    hl.dsp.exec_cmd("kitty", {
                      float = true,
                      size = { "50%", "50%" }
                    })
                  ''))
                  (bind (modKey "Q") closeWindow)

                  # Using hyprshutdown is preferred over hl.dsp.exit().
                  (bindExec (modKey "M") "hyprshutdown")
                  (bindExec (modKey "E") "dolphin")
                  (bind (modKey "ALT + E") (lua ''
                    hl.dsp.exec_cmd("dolphin", {
                      float = true,
                      size = { "50%", "50%" }
                    })
                  ''))

                  (bindExec (modKey "B") "firefox")
                  (bindExec (modKey "C") "codium")
                  (bindExec (modKey "Y") "freetube")
                  (bindExec (modKey "D") "vesktop")

                  # Window actions
                  (bind (modKey "V") toggleFloat)
                  (bind (modKey "P") togglePin)
                  (bind (modKey "F") toggleFullscreen)

                  (bind (modKey "SHIFT + F") (lua ''
                    hl.dsp.window.fullscreen_state({
                      internal = -1,
                      client = 2
                    })
                  ''))

                  (bindExec (modKey "R") "walker")
                  (bindExec (modKey "period") "walker -m emojis")
                  (bind (modKey "S") togglePseudo)
                  (bindExec (modKey "L") "hyprlock")

                  # Clipboard
                  (bindExec (modKey "H") "cliphist list | wofi -d | cliphist decode | ifne wl-copy")
                  (bindExec (modKey "SHIFT + H") "cliphist list | wofi -d | cliphist delete")
                  (bindExec (modKey "SHIFT + CTRL + H") "cliphist wipe")
                  (bindExec (modKey "SHIFT + Z") "systemctl suspend")

                  # Focus
                  (bind (modKey "left") (focusDirection "l"))
                  (bind (modKey "right") (focusDirection "r"))
                  (bind (modKey "up") (focusDirection "u"))
                  (bind (modKey "down") (focusDirection "d"))

                  # Monitor configuration
                  (bindExec (modKey "SHIFT + E") "hyprctl keyword monitor ,preferred,auto,1")
                  (bindExec (modKey "SHIFT + D") "hyprctl keyword monitor ,preferred,auto,1,mirror,eDP-1")

                  # Screen rotation
                  (bindExec (modKey "SHIFT + R") "hyprctl keyword monitor eDP-1,3072x1920@120,auto,2,transform,0")
                  (bindExec (modKey "SHIFT + T") "hyprctl keyword monitor eDP-1,3072x1920@120,auto,2,transform,1")

                  # Groups
                  (bind (modKey "G") toggleGroup)
                  (bind (modKey "TAB") nextGroup)

                  # Screenshots
                  (bindExec (modKey "SHIFT + S") "grimblast --notify copy area")
                  (bindExec "Print" "grimblast --notify --cursor copy output")
                  (bindExec "ALT + Print" "grimblast --notify --cursor copy screen")

                  # Color picker
                  (bindExec (modKey "SHIFT + C") "hyprpicker -a")

                  # Workspaces
                  (bind (modKey "1") (focusWorkspace "1"))
                  (bind (modKey "2") (focusWorkspace "2"))
                  (bind (modKey "3") (focusWorkspace "3"))
                  (bind (modKey "4") (focusWorkspace "4"))
                  (bind (modKey "5") (focusWorkspace "5"))
                  (bind (modKey "6") (focusWorkspace "6"))
                  (bind (modKey "7") (focusWorkspace "7"))
                  (bind (modKey "8") (focusWorkspace "8"))
                  (bind (modKey "9") (focusWorkspace "9"))
                  (bind (modKey "0") (focusWorkspace "10"))

                  # Cycle workspaces
                  (bind (modKey "CTRL + right") (focusWorkspace "e+1"))
                  (bind (modKey "CTRL + left") (focusWorkspace "e-1"))

                  # Move window and follow it
                  (bind (modKey "SHIFT + 1") (moveWorkspace "1"))
                  (bind (modKey "SHIFT + 2") (moveWorkspace "2"))
                  (bind (modKey "SHIFT + 3") (moveWorkspace "3"))
                  (bind (modKey "SHIFT + 4") (moveWorkspace "4"))
                  (bind (modKey "SHIFT + 5") (moveWorkspace "5"))
                  (bind (modKey "SHIFT + 6") (moveWorkspace "6"))
                  (bind (modKey "SHIFT + 7") (moveWorkspace "7"))
                  (bind (modKey "SHIFT + 8") (moveWorkspace "8"))
                  (bind (modKey "SHIFT + 9") (moveWorkspace "9"))
                  (bind (modKey "SHIFT + 0") (moveWorkspace "10"))

                  # Move window without following it
                  (bind (modKey "CTRL + SHIFT + 1") (moveWorkspaceSilent "1"))
                  (bind (modKey "CTRL + SHIFT + 2") (moveWorkspaceSilent "2"))
                  (bind (modKey "CTRL + SHIFT + 3") (moveWorkspaceSilent "3"))
                  (bind (modKey "CTRL + SHIFT + 4") (moveWorkspaceSilent "4"))
                  (bind (modKey "CTRL + SHIFT + 5") (moveWorkspaceSilent "5"))
                  (bind (modKey "CTRL + SHIFT + 6") (moveWorkspaceSilent "6"))
                  (bind (modKey "CTRL + SHIFT + 7") (moveWorkspaceSilent "7"))
                  (bind (modKey "CTRL + SHIFT + 8") (moveWorkspaceSilent "8"))
                  (bind (modKey "CTRL + SHIFT + 9") (moveWorkspaceSilent "9"))
                  (bind (modKey "CTRL + SHIFT + 0") (moveWorkspaceSilent "10"))

                  # Move window between relative workspaces
                  (bind (modKey "SHIFT + right") (moveWorkspace "r+1"))
                  (bind (modKey "SHIFT + left") (moveWorkspace "r-1"))

                  # Mouse wheel workspace switching
                  (bind (modKey "mouse_down") (focusWorkspace "e+1"))
                  (bind (modKey "mouse_up") (focusWorkspace "e-1"))

                  # Mouse window movement/resizing
                  (bindWith { mouse = true; } (modKey "mouse:272") (lua "hl.dsp.window.drag()"))
                  (bindWith { mouse = true; } "ALT + mouse:272" (lua "hl.dsp.window.resize()"))

                  # Media keys
                  (bindExecWith { locked = true; } "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

                  (bindExecWith {
                    locked = true;
                    repeating = true;
                  } "XF86AudioRaiseVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")

                  (bindExecWith {
                    locked = true;
                    repeating = true;
                  } "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")

                  (bindExecWith {
                    locked = true;
                    repeating = true;
                  } "XF86MonBrightnessDown" "brightnessctl set 5%-")

                  (bindExecWith {
                    locked = true;
                    repeating = true;
                  } "XF86MonBrightnessUp" "brightnessctl set 5%+")
                ];

            }
            (lib.mkIf cfg.hidpi {
              config.xwayland.force_zero_scaling = true;
              env = [
                {
                  _args = [

                    "GDK_SCALE"
                    "2"
                  ];
                }
                {
                  _args = [

                    "XCURSOR_SIZE"
                    "24"
                  ];
                }
              ];
            })
          ];
        };
      };
    };
}
