# Setup fzf
# ---------
if [[ ! "$PATH" == */home/orkung/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/orkung/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/orkung/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/orkung/.fzf/shell/key-bindings.bash"
