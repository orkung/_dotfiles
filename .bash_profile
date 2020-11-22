if [ -f ~/.bashrc ]; then
       source ~/.bashrc
fi
eval "$(pyenv virtualenv-init -)"

export EDITOR="vim"
export TERMINAL="gnome-terminal"
export BROWSER="chromium-browser"
export READER="zathura"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
