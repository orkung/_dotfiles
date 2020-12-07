# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cavitg/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cavitg/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cavitg/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/cavitg/.fzf/shell/key-bindings.bash"
