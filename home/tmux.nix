{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      yank
      dracula
    ];
    extraConfig = ''
      set -g @yank_action 'copy-pipe'
      set -g @yank_with_mouse off
      unbind -T copy-mode-vi MouseDragEnd1Pane
      unbind -T copy-mode MouseDragEnd1Pane

      # New window path
      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
    '';
  };
}
