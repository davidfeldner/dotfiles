{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      yank
      catppuccin
    ];

    extraConfig = ''
      set-option -g status-position top 

      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_text "#W"

      set -g @ctp_bg "#ff0000"
      set -g @ctp_surface_1 "#00ff00"
      set -g @ctp_fg "#0000ff"
      set -g @ctp_mauve "#00ffff"
      set -g @ctp_crust "#ffff00"


      set -g @yank_action 'copy-pipe'
      set -g @yank_with_mouse off
      unbind -T copy-mode-vi MouseDragEnd1Pane
      unbind -T copy-mode MouseDragEnd1Pane

      # New window path
      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # Fix vim tmux escape time
      set -s escape-time 0

      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };
}
