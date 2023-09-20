# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/david/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#Exports
export OPENCV_LOG_LEVEL=ERROR
### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

export PATH=$PATH:/home/david/.local/bin
export QT_QPA_PLATFORMTHEME=qt5ct
export ZSH_COLORIZE_STYLE="vim"
export GTK_THEME=Catppuccin-Mocha-Standard-Blue-dark
export QT_STYLE_OVERRIDE=Catppuccin-Mocha-Standard-Blue-dark
export DOTNET_CLI_TELEMETRY_OPTOUT=true
source ~/.config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh-plugins/LS_COLORS.sh
source ~/.config/zsh-plugins/colorize.plugin.zsh
eval "$(starship init zsh)"

alias bunx="bun x"
alias ls="ls --color"
alias cat="ccat"
alias icat="kitten icat"
alias diff="kitten diff"
alias ssh="kitten ssh"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
