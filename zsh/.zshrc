# ~/.zshrc

# --- Path config ---
path=(
    $path
    $HOME/bin
    $HOME/.local/bin
)

# deduplicate and remove non existent paths
typeset -U path
path=($^path(N-/))

export PATH

# --- set vim style input ---
bindkey -v

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_VERIFY

# --- Directory / navigation ---
setopt AUTO_CD
setopt NO_CASE_GLOB

# --- Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt LIST_AMBIGUOUS

# --- Plugins ---
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Editor ---
export EDITOR=nvim
export VISUAL=nvim

# --- Aliases ---
[[ -f ~/.aliases ]] && source ~/.aliases

# --- Homebrew ---
[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# --- Starship prompt ---
# prevent recursive definition of zle keymap
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"

# --- zoxide ---
eval "$(zoxide init zsh --cmd cd)"

# --- fzf ---
source <(fzf --zsh)

# --- Disable flow control ---
stty -ixon

# --- Machine-specific local config ---
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
