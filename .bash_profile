if [ -f "$HOME/.bashrc" ]; then
       source $HOME/.bashrc
fi
export TERM="screen-256color"
export EDITOR="vim"
#export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'
export PATH=${HOME}/.rvm/gems/ruby-2.5.0@task-web:/usr/local/bin:${HOME}/bin:${HOME}/.rvm/gems/ruby-2.7.1/bin:${HOME}/.rvm/bin:${HOME}/.pyenv/bin:${HOME}/.local/bin:${HOME}/.pyenv/versions/3.9.0/bin:${HOME}/.pyenv/versions/2.7.18/bin:${HOME}/.local/lib/python2.7/site-packages:${HOME}/.cargo/bin:${HOME}/Downloads/crc-linux-1.25.0-amd64:/home/orkun/.crc/bin/oc:/usr/share/rvm/bin:/home/cavitg/.local/bin:$PATH
export HOST_IP="$(ip route | awk '/^default/{print $3}')"
export PULSE_SERVER="tcp:$HOST_IP"
export DISPLAY="$HOST_IP:0.0"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd'
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export SHELL="/bin/bash --login"
#export VSCODE_IPC_HOOK_CLI=$(ls -t /run/user/$UID/vscode-ipc-*.sock | head -1)
export VSCODE_IPC_HOOK_CLI=$(lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi ;; esac

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
#xmodmap ~/.Xmodmap
#export PYTHONPATH="$HOME/taskwarrior_tools/tasklib:$PYTHONPATH"
#export PYTHONPATH="$HOME/.pyenv/versions/3.9.0/lib/python3.9/site-packages:$HOME/.local/lib/python3.9/site-packages:$PYTHONPATH"
#eval "$(pyenv virtualenv-init -)"
#export TERM="xterm-256color"
#export TERM="tmux-256color"
#export TERM="screen-256color-bce"
#export GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`
#export TERMINAL="gnome-terminal"
#export BROWSER="brave-browser"
#export READER="zathura"
#export MANPATH="$MANPATH:$HOME/man"
#export MANSECT="1:n:l:8:3:2:3posix:3pm:3perl:5:4:9:6:7:pj"
#export MANSECT=$(pcregrep -o1 MANSECT\\s\{2,\}\(.*\) /etc/man.conf):pj
