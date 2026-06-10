# ~/.zshrc
# History
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Shell options
setopt autocd
setopt CORRECT
setopt checkwinsize 2>/dev/null

# Environment
export EDITOR=nvim
export VISUAL=nvim

# Completion
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Prompt
eval "$(starship init zsh)"

# Greeting
clear && myfetch -c 8 -C " █"

# Aliases - Listing
alias ls='ls --color=auto'
alias lsd='eza --icons'
alias la='ls -a'
alias lo='eza -s modified'
alias grep='grep --color=auto'

# Aliases - Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Aliases - System
alias update='yay -Syu'
alias fonts='fc-list -f "%{family}\n"'
alias tasks='btm'
alias off='sudo shutdown -h now'
alias loop='sudo reboot'

# Aliases - Configs
alias settings='nvim ~/.config/hypr/hyprland.lua'

# Aliases - Fetches & toys
alias f='clear && myfetch -c 8 -C " █"'
alias ff='clear && fastfetch'
alias pool='clear && asciiquarium'

# Aliases - Editors/nav
alias n='nvim'
alias docs='cd ~/Documents && nvim'

# Aliases - Network
alias school-vpn='sudo openconnect vpn.ncsu.edu'

# key-bindings
bindkey '^f' autosuggest-accept # Ctrl + f
bindkey -e # Emacs bindings
bindkey '^[[1;5D' backward-word # Cntrl + left arrow
bindkey '^[[1;5C' forward-word # Cntrl + right arrow

# Functions
catclip() {
    cat "$@" | wl-copy
}

# Lazy load nvm
nvm() {
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# Fix invisible text when typing variables with pywal
ZSH_HIGHLIGHT_STYLES[comment]='fg=white,bold'
# Optional: Also fix 'unknown-token' if the above doesn't catch every case
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white,bold'
