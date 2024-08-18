{ ... }:

{
  enable = true;
  style = builtins.readFile ./waybar.css;
  settings = {
    mainBar = {
      "layer" = "top";
      "position" = "top";
      "mod" = "dock";
      "margin-left" = 0;
      "margin-right" = 0;
      "margin-top" = 0;
      "margin-bottom" = 0;
      "exclusive" = true;
      "passtrough" = false;
      "gtk-layer-shell" = true;
      "height" = 0;
      "modules-left" = [
        "clock"
        #//"custom/weather",
        "idle_inhibitor"
        "hyprland/language"
      ];
      "modules-center" = [
        "hyprland/workspaces"
      ];
      "modules-right" = [
        "tray"
        "network"
        "backlight"
        "pulseaudio"
        "battery"
      ];

      "hyprland/window" = {
        "max-length" = 200;
        "separate-outputs" = true;
        "format" = "{}";
      };
      "hyprland/workspaces" = {
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "all-outputs" = true;
        "on-click" = "activate";
        "format" = "{icon}";
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };
      "network" = {
        #// "interface": "wlp2*", // (Optional) To force the use of this interface
        "format-wifi" = "  {essid}";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "⚠ Disconnected";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      "backlight" = {
        #// "device": "acpi_video1",
        "format" = "{icon}  {percent}%";
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
      };
      "battery" = {
        "states" = {
          # // "good": 95;
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon}  {capacity}%";
        "format-charging" = "󱐋 {capacity}%";
        "format-plugged" = " {capacity}%";
        "format-alt" = "{icon} {time}";
        #// "format-good": "", // An empty format will hide the module;
        #// "format-full": "",;
        "format-icons" = [ "" "" "" "" "" ];
      };
      "battery#bat2" = {
        "bat" = "BAT2";
      };
      "custom/updates" = {
        "exec" = "(checkupdates) | wc -l";
        "interval" = 3600;
        "format" = "󰑓 {}";
      };
      "custom/weather" = {
        "tooltip" = true;
        "format" = "{}";
        "restart-interval" = 1000;
        "exec" = "~/.config/waybar/scripts/waybar-wttr.py";
        "return-type" = "json";
      };
      "tray" = {
        "icon-size" = 13;
        "tooltip" = false;
        "spacing" = 10;
      };
      "clock" = {
        "format" = " {:%R   %d/%m}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "tooltip" = false;
        "format-muted" = " Muted";
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
      };
      "pulseaudio#microphone" = {
        "format" = "{format_source}";
        "tooltip" = false;
        "format-source" = " {volume}%";
        "format-source-muted" = " Muted";
        "on-click" = "pamixer --default-source -t";
        "on-scroll-up" = "pamixer --default-source -i 5";
        "on-scroll-down" = "pamixer --default-source -d 5";
        "scroll-step" = 5;
      };
      "hyprland/submap" = {
        "format" = "✌️ {}";
        "max-length" = 8;
        "tooltip" = false;
      };
      "hyprland/language" = {
        "format" = "{}";
        "format-en" = "US";
        "format-da" = "DK";
        "keyboard-name" = "at-translated-set-2-keyboard";
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
      };
    };
  };
    }
