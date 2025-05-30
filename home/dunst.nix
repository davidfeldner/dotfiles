{ lib, ... }:

{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      follow = "mouse";
      indicate_hidden = "yes";

      offset = "10x10";

      notification_height = 0;

      separator_height = 2;

      padding = 8;
      horizontal_padding = 8;
      text_icon_padding = 0;
      frame_width = 2;

      frame_color = lib.mkDefault "#22aaaa";
      separator_color = lib.mkDefault "frame";

      sort = "yes";
      idle_threshold = 120;
      # font = "monospace 10";
      line_height = 0;
      markup = "full";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      word_wrap = "yes";
      stack_duplicates = true;
      hide_duplicate_count = false;

      show_indicators = "yes";

      min_icon_size = 0;
      max_icon_size = 64;

      icon_path = "/usr/share/icons/Papirus-Dark/16x16/status/:/usr/share/icons/Papirus-Dark/16x16/devices/:/usr/share/icons/Papirus-Dark/16x16/actions/:/usr/share/icons/Papirus-Dark/16x16/animations/:/usr/share/icons/Papirus-Dark/16x16/apps/:/usr/share/icons/Papirus-Dark/16x16/categories/:/usr/share/icons/Papirus-Dark/16x16/emblems/:/usr/share/icons/Papirus-Dark/16x16/emotes/:/usr/share/icons/Papirus-Dark/16x16/devices/mimetypes:/usr/share/icons/Papirus-Dark/16x16/panel/:/usr/share/icons/Papirus-Dark/16x16/places/";

      dmenu = "/usr/bin/rofi -p dunst:";
      browser = "/usr/bin/brave";

      title = "Dunst";
      class = "Dunst";

      corner_radius = 10;
      timeout = 5;

    };
    urgency_low = {
      background = lib.mkDefault "#1D2021";
      foreground = lib.mkDefault "#22aaaa";
    };

    urgency_normal = {
      background = lib.mkDefault "#1D2021";
      foreground = lib.mkDefault "#E8E3E3";
    };

    urgency_critical = {
      background = lib.mkDefault "#1D2021";
      foreground = lib.mkDefault "#AD685A";
      frame_color = lib.mkDefault "#DD8F6E";
    };
  };
}
