{ config, lib, ... }:
{
  programs.zellij = {
    enable = true;
    exitShellOnExit = true;
    attachExistingSession = true;
    settings = {
      show_startup_tips = false;
      cleanup = true;
    };
    themes.stylix.themes.default = {
      fg = lib.mkForce "#${config.lib.stylix.colors.base0B}";
      green = lib.mkForce "#${config.lib.stylix.colors.base05}";
    };
  };
}
