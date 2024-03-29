fzf-history-widget() {
  setopt extendedglob
  fc -R ~/.zsh_history
  LBUFFER=$(fc -l -n -1 0 | awk '!x[$0]++' | fzf --height=40% --border --prompt="Select command: " --query="$LBUFFER")
  zle redisplay
}

__reload_history() {
  fc -R ~/.zsh_history
}

add-zsh-hook preexec __reload_history

zle -N fzf-history-widget
bindkey '^r' fzf-history-widget
bindkey '^[[A' fzf-history-widget
bindkey '^[OA' fzf-history-widget