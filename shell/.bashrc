# ~/.bashrc

# Exit early if not interactive
[[ $- != *i* ]] && return

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Shell options
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

# Environment
export EDITOR=nvim
export VISUAL=nvim

# Completion
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# fzf if installed
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

# Prompt
eval "$(starship init bash)"

# Greeting
clear && myfetch -c 8 -C " █"

# Listing
alias ls='ls --color=auto'
alias lsd='eza --icons'
alias la='ls -a'
alias lo='eza -s modified'
alias grep='grep --color=auto'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# System
alias update='yay -Syu'
alias fonts='fc-list -f "%{family}\n"'
alias tasks='btm'
alias off='sudo shutdown -h now'
alias loop='sudo reboot'

# Configs
alias settings='nvim ~/.config/hypr/hyprland.lua'

# Fetches & toys
alias f='clear && myfetch -c 8 -C " █"'
alias ff='clear && fastfetch'
alias pool='clear && asciiquarium'

# Editors / nav
alias n='nvim'
alias docs='cd ~/Documents && nvim'

# Network
alias school-vpn='sudo openconnect vpn.ncsu.edu'

# Functions
catclip() {
    cat "$@" | wl-copy
}

# lazy load nvm
nvm() {
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}
