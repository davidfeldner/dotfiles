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

export PATH=$PATH:/home/david/.local/bin:$(go env GOPATH)/bin
export QT_QPA_PLATFORMTHEME=qt5ct
export ZSH_COLORIZE_STYLE="vim"
export GTK_THEME=Catppuccin-Mocha-Standard-Blue-Dark
export QT_STYLE_OVERRIDE=Catppuccin-Mocha-Standard-Blue-dark
export DOTNET_CLI_TELEMETRY_OPTOUT=true
source ~/.config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh-plugins/LS_COLORS.sh
source ~/.config/zsh-plugins/colorize.plugin.zsh
eval "$(starship init zsh)"

alias ls="ls --color"

alias icat="kitten icat"
alias diff="kitten diff"
alias ssh="kitten ssh"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias protoc='protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative'
