{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [ yank ];
    extraConfig = ''
      set -g @yank_action 'copy-pipe'
    '';
  };
}
