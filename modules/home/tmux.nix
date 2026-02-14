{ ... }:
{
  flake.modules.homeManager.tmux =
    { pkgs, ... }:

    {
      programs.tmux = {
        enable = true;
        mouse = true;
        plugins = with pkgs.tmuxPlugins; [
          yank
          vim-tmux-navigator
        ];

        extraConfig = ''
          set-option -g status-position top 

          # Set status bar colors
          set -g status-style bg=black,fg=white

          # Left side: session name with arrow to next section
          set -g status-left "#[bg=blue,fg=black] #S #[bg=black,fg=blue]"

          # Right side: time with arrow
          set -g status-right "#[bg=black,fg=green]#[bg=green,fg=black] %H:%M "

          # Window list: each window name with separators
          set -g window-status-format "#[bg=black,fg=cyan] #I:#W #[fg=black,bg=black]"
          set -g window-status-current-format "#[bg=cyan,fg=black] #I:#W #[fg=cyan,bg=black]"

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

          # Smart pane switching with awareness of Vim splits.
          # See: https://github.com/christoomey/vim-tmux-navigator
          vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +''${vim_pattern}$'"
          bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
          bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
          bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
          bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l
        '';
      };
    };
}
