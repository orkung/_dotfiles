# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#export SHELL="/bin/bash --login"
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000
# Set no limit for history file size
HISTFILESIZE=-1
HISTSIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \n'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ \n'
fi
set color_prompt force_color_prompt
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -ld .?*'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
set -o vi
function pushla () {
    git add . 
    git commit -a -m "$1" 
    git push origin master
}

#zl() {
#    ~/bin/zargan.py $1 |less
#}

zl(){
    ~/bin/zargan.py $@ 2>/dev/null | head -10
}
export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
#    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

#vex(){
#}

# Fire up a new server according to the argument supplied
vexp(){
    export VI_SERVER=$1
}
vsrv(){
    vexp $1
    vim --servername $I_SERVER
}

# Open up the files in the environment Vim server.
vop(){
    vim --servername $VI_SERVER --remote-silent $*
}

#export PATH=""

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="${HOME}/.rvm/gems/ruby-2.5.0@task-web:/usr/local/bin:${HOME}/bin:${HOME}/.rvm/gems/ruby-2.7.1/bin:${HOME}/.rvm/bin:${HOME}/.pyenv/bin:${HOME}/.local/bin:${HOME}/.pyenv/versions/3.9.0/bin:${HOME}/.pyenv/versions/2.7.18/bin:${HOME}/.local/lib/python2.7/site-packages:${HOME}/.cargo/bin:${HOME}/Downloads/crc-linux-1.25.0-amd64:$PATH"
#PATH="/usr/local/bin:${HOME}/.rvm/gems/ruby-2.5.0@task-web:/usr/local/bin:${HOME}/bin:${HOME}/.rvm/gems/ruby-2.7.1/bin:${HOME}/.rvm/bin:${HOME}/.pyenv/bin:${HOME}/.local/bin:${HOME}/.pyenv/versions/3.9.0/bin:${HOME}/.pyenv/versions/2.7.18/bin:$PATH"
#export PATH="${HOME}/google-cloud-sdk/bin:${HOME}/bin:${HOME}/.rvm/gems/ruby-2.7.1/bin:${HOME}/.rvm/bin:${HOME}/.pyenv/bin:$PATH"
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# Print the timestamp of each command
HISTTIMEFORMAT='%F %T '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

# https://zork.net/~st/jottings/How_to_limit_the_length_of_your_bash_prompt.html
# shell and we should not mess with it.
#if [ -n "$PS1" ]; then
#    # A temporary variable to contain our prompt command
#    NEW_PROMPT_COMMAND='
#        TRIMMED_PWD=${PWD: -20};
#        TRIMMED_PWD=${TRIMMED_PWD:-$PWD}
#    '
#
#    # If there's an existing prompt command, let's not 
#    # clobber it
#    if [ -n "$PROMPT_COMMAND" ]; then
#        PROMPT_COMMAND="$PROMPT_COMMAND;$NEW_PROMPT_COMMAND"
#    else
#        PROMPT_COMMAND="$NEW_PROMPT_COMMAND"
#    fi
#
#    # We're done with our temporary variable
#    unset NEW_PROMPT_COMMAND
#
#    # Set PS1 with our new variable
#    # \h - hostname, \u - username
#    PS1='\u@\h:$TRIMMED_PWD\$ '
#fi
#
## https://zork.net/~st/jottings/Per-Host_Prompt_Colouring.html
## hosthash might be negative on 32-bit machines, and that would mess
## things up.
#HOSTHASH=$(hostname | md5sum)
#HOSTHASH=${HOSTHASH:0:7}
#
## Map into the range of available colours
#if [ $(tput colors) -ge 256 ]; then
#    # All the colours with brightness > 25% in the default xterm
#    # palette
#    BRIGHT_COLORS=(2 3 4 5 6 7 8 9 10 11 12 13 14 15 22 23 24 25 26 27
#    28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
#    50 51 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77
#    78 79 80 81 82 83 84 85 86 87 94 95 96 97 98 99 100 101 102 103 104
#    105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121
#    122 123 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144
#    145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 165 166
#    167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183
#    184 185 186 187 188 189 190 191 192 193 194 195 198 199 200 201 202
#    203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219
#    220 221 222 223 224 225 226 227 228 229 230 231 238 239 240 241 242
#    243 244 245 246 247 248 249 250 251 252 253 254 255)
#elif [ $(tput colors) -ge 16 ]; then
#    BRIGHT_COLORS=(2 3 4 5 6 7 8 9 10 11 12 13 14 15)
#else
#    BRIGHT_COLORS=(2 3 4 5 6 7)
#fi
#
#COLOR=${BRIGHT_COLORS[$(( 0x$HOSTHASH % ${#BRIGHT_COLORS[@]} ))]}
#
#C="\[$(tput setaf $COLOR)\]" # color
#B="\[$(tput bold)\]" # bold
#N="\[$(tput sgr0)\]" # normal
##PS1="$C$B[$N$C\\u@\\h$B\$\w$N$C\$\W$B]\\\$$N"
##PS1="$C$B[$N$C\\u@\\h$B\$TMP_DELIM$N$C\$TMP_PWD_VALUE$B]\\\$$N"
#PS1="$C$B[$N$C\\u@\\h$B:\$TRIMMED_PWD$N$C\$TMP_PWD_VALUE$B]\\\$$N"
#unset HOSTHASH BRIGHT_COLORS COLOR C B N          # cleanup
#export PS1="$PS1\n"

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '${HOME}/google-cloud-sdk/path.bash.inc' ]; then . '${HOME}/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '${HOME}/google-cloud-sdk/completion.bash.inc' ]; then . '${HOME}/google-cloud-sdk/completion.bash.inc'; fi
#export CLOUDSDK_COMPUTE_REGION=us-central1
#export CLOUDSDK_COMPUTE_ZONE=us-central1-f
if [ -s "${HOME}/.rvmrc" ]; then
    source "${HOME}/.rvmrc"
fi # to have $rvm_path defined if set
if [ -s "${rvm_path-${HOME}/.rvm}/scripts/rvm" ]; then
    source "${rvm_path-${HOME}/.rvm}/scripts/rvm"
fi


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/share/rvm/bin"

# Running under WSL (Windows Subsystem for Linux)?
if uname -r |egrep -q '*microsoft*' ; then
        WSL_running=true
    else
        WSL_running=false
fi
 
if [[ $WSL_running == false ]]; then
  function _update_ps1() {
      PS1="$(powerline-shell $?)\n"
  }
fi

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi
#source "/etc/profile.d/rvm.sh"
source /usr/share/autojump/autojump.sh
#alias tmux="TERM=xterm-256color /usr/bin/tmux"
#alias tmux="TERM=screen-256color-bce tmux"
alias tmux="TERM=screen-256color tmux"
#alias tmux="TERM=tmux-256color tmux"
#alias tmux='tmux new "export TERM=screen-256color-bce; $SHELL"' 
#export TERM="xterm-256color"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
#alias tami="export TASKRC=${HOME}/.task_misc"
#alias tawo="unset TASKRC"
#alias t="/bin/task"
#alias ta='/bin/task add pro:"$1" pri:"$2" "$3"' 
alias tr="task ready"
alias trpw="tr pro:work"
alias trpb="tr pro:budget"
alias trpm="tr pro:misc"
alias trph="tr pro:home"
alias trpc="tr pro:comp"

alias tc="task context"
alias tcd="tc devops"
alias tcn="tc none"

taskaddlong () {
    task add +next pro:$1 pri:$2 +$3 due:$4 scheduled:$5 wait:$6 $7
}

taskaddshort () {
    task add pro:$1 pri:$2 +$3 due:$4 $5
}
alias reload="source ~/.bashrc"

alias tal=taskaddlong
alias tas=taskaddshort

alias ttcd="~/bin/tt context devops ; sleep 0.1 ; ~/bin/tt"
alias ttcn="tt context none ; sleep 0.1 ; ~/bin/tt"
alias ttpn="~/bin/tt ready pro: ; sleep 0.1 ; ~/bin/tt"
alias ttpb="~/bin/tt ready pro:budget"
alias ttpc="~/bin/tt ready pro:comp"
alias ttpm="~/bin/tt ready pro:misc"
alias ttph="~/bin/tt ready pro:home"
alias ttpw="~/bin/tt ready pro:work" 
alias ttpwsu="~/bin/tt ready pro:work.support" 
alias ttpwmi="~/bin/tt ready pro:work.misc" 
alias ttpwop="~/bin/tt ready pro:work.ops" 
alias ttpwde="~/bin/tt ready pro:work.dev" 
#alias ttpn="~/bin/tt long pro:"
#alias ttpw="~/bin/tt long pro:work ; sleep 0.1 ; ~/bin/tt"
#alias ttc="~/bin/tt context comp ; sleep 0.1 ; ~/bin/tt"
#alias tth="~/bin/tt context home ; sleep 0.1 ; ~/bin/tt"
#alias ttm="~/bin/tt context misc ; sleep 0.1 ; ~/bin/tt"
#alias ttb="~/bin/tt context budget ; sleep 0.1 ; ~/bin/tt"

# from vejetaryenvampir https://notabug.org/vejetaryenvampir/dots/src/master/.config/shortcuts/aliases
tur(){ curl -s "https://tureng.com/en/turkish-english/$(echo "$@" | tr [A-Z] [a-z])" | elinks -dump | sed '1,60d;/Pronunciation in context/q' | less; }
tdk(){ curl -s "http://www.tdk.gov.tr/index.php?option=com_gts&view=gts&kelime=$*" | elinks -dump | sed '1,65d;/kez söz arandı./q' | less; }
#et() { sdcv -nu "Babylon English-Turkish" "$@" | sed -e "/^-->.*$/d" -e "s/\r\r/\r/" -e "s/<font.*\">/$(printf "\e[34m")/" -e "s/<\/font>/$(printf "\e[00m")/"; }
#alias te="sdcv -cu Turkish-English"
function ta_proj() { echo "$2" | vipe | tr '\n' '\0' | xargs -0 -n1 -t task add "project:$1"; }

taskaddworksupport () {
    task add pro:work.support pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworksupport () {
    task add pro:work.support pri:$1 +$2 due:$3 $4
}
alias tawsu=taskaddworksupport
alias taswsu=taskaddshortworksupport

taskaddworkmisc () {
    task add pro:work.misc pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkmisc () {
    task add pro:work.misc pri:$1 +$2 due:$3 $4
}
alias tawmi=taskaddworkmisc
alias taswmi=taskaddshortworkmisc

taskaddworkdev () {
    task add pro:work.dev pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkdev () {
    task add pro:work.dev pri:$1 +$2 due:$3 $4
}
alias tawde=taskaddworkdev
alias taswde=taskaddshortworkdev

taskaddworkops () {
    task add pro:work.ops pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkops () {
    task add pro:work.ops pri:$1 +$2 due:$3 $4
}
alias tawop=taskaddworkops
alias taswop=taskaddshortworkops

# If use_tmux=1, add these codes to .bashrc/.zshrc:
#[[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
#       [[ -n "$ATTACH_ONLY" ]] && {
#           tmux a 2>/dev/null || {
#               cd && exec tmux
#        }
#        exit
#    }
#    tmux new-window task-pane && tmux new-window task-web && tmux select-window -t 1 && tmux kill-window 2>/dev/null && exec tmux a
##   tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
##tmux new-session -d ; tmux set -g status off ; tmux split-window ; tmux select-pane -t 0 tmux send-keys "${HOME}/bin/task-pane" "Enter" ; tmux new-window ; tmux select-window -t 1 ; tmux send-keys "${HOME}/.rvm/gems/ruby-2.5.0@task-web/bin/task-web" "Enter" ; tmux kill-window
#    exec tmux
#}
#!/bin/bash

#export TASKRC="~/.task_old/.taskrc"
taskaddworkrefund () {
    task add pro:work.refund pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkrefund () {
    task add pro:work.refund pri:$1 +$2 due:$3 $4
}
alias tawref=taskaddworkrefund
alias taswref=taskaddshortworkrefund
#alias oc="/mnt/c/Users/Kafein/.crc/bin/oc/oc.exe"
alias toast='powershell.exe -command New-BurntToastNotification'
alias tp='trans -p'
#eval "$(register-python-argcomplete pipx)"
export HOST_IP="$(ip route |awk '/^default/{print $3}')"
export PULSE_SERVER="tcp:$HOST_IP"
export DISPLAY="$HOST_IP:0.0"
alias gacp="git add -A && git commit -m "." && git push"
function entr() {
trans :tr "$1" |head -n 25
}
function tren() {
trans :en "$1" |head -n 25
}

function enen() {
trans :en "$1" |head -n 25
}

export FZF_DEFAULT_COMMAND='fd'
#xmodmap ~/.Xmodmap
#eval $(crc oc-env)
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
