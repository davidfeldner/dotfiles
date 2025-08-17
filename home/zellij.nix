{ config, lib, ... }:
{
  programs.zellij = {
    enable = true;
    exitShellOnExit = false;
    # attachExistingSession = true;
    settings = {
      show_startup_tips = false;
      cleanup = true;
    };
    themes.stylix.themes.default = {
      ribbon_unselected.background = lib.mkForce "#${config.lib.stylix.colors.base04}";
    };
  };
}
