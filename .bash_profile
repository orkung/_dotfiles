if [ -f "$HOME/.bashrc" ] ; then
       source $HOME/.bashrc
fi
eval "$(pyenv virtualenv-init -)"

export GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`
export EDITOR="vim"
export TERMINAL="gnome-terminal"
export BROWSER="brave-browser"
export READER="zathura"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
#export PYTHONPATH="$HOME/Git_repolari/diger/taskwarrior_tools/tasklib:$HOME/.local/lib/python3.9/site-packages:$HOME/.pyenv/versions/3.9.0/lib/python3.9/site-packages:$PYTHONPATH"
#export PYTHONPATH="$HOME/.pyenv/versions/3.9.0/lib/python3.9/site-packages:$HOME/.local/lib/python3.9/site-packages:$PYTHONPATH"


if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
