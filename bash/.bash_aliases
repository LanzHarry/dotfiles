# general QoL
alias vim="nvim"
alias vi="nvim"
alias nv="nvim"
alias py="python3"
alias python="python3"
alias ls="lsd"
alias ll='ls -alF'
alias la='ls -A'
alias lst="ls --tree -I .git -I node_modules"

# navigation
alias ..='cd ..'
alias ...='cd ../..'

# git
alias gs='git status -u'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'

# docker
alias dps='docker ps'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# quick config editing
alias bashrc='nvim ~/dotfiles/bash/.bashrc && source ~/.bashrc'
alias aliases='nvim ~/dotfiles/bash/.bash_aliases && source ~/.bash_aliases'
