# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
# but only if not SUDOing and have SUDO_PS1 set; then assume smart user.
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac
export PROMPT_COMMAND='history -a'

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ]; then
    case " $(groups) " in *\ admin\ * | *\ sudo\ *)
        if [ -x /usr/bin/sudo ]; then
            cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.

	EOF
        fi
        ;;
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
        # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
            /usr/lib/command-not-found -- "$1"
            return $?
        elif [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    }
fi
# Print the timestamp of each command
export HISTTIMEFORMAT="%F %T "

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Set no limit for history file size
HISTFILESIZE=-1
HISTSIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \n"
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ \n"
fi
set color_prompt force_color_prompt
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

zl() {
    ~/bin/zargan.py $@ 2>/dev/null | head -10
}

# Running under WSL (Windows Subsystem for Linux)?
if uname -r | egrep -q '*microsoft*'; then
    WSL_running=true
else
    WSL_running=false
fi

source /usr/share/autojump/autojump.sh
tur() { curl -s "https://tureng.com/en/turkish-english/$(echo "$@" | tr [A-Z] [a-z])" | elinks -dump | sed '1,60d;/Pronunciation in context/q' | less; }
tdk() { curl -s "http://www.tdk.gov.tr/index.php?option=com_gts&view=gts&kelime=$*" | elinks -dump | sed '1,65d;/kez söz arandı./q' | less; }
function entr() {
    trans :tr "$1" | head -n 25
}
function tren() {
    trans :en "$1" | head -n 25
}

function enen() {
    trans :en "$1" | head -n 25
}

export GO111MODULE=on

um() {
    code ~/man/manpj/*$1*
}

umls() {
    ls -1 ~/man/manpj/*
}

parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\u@\h:\[\e[32m\]\w\[\e[91m\]\$(parse_git_branch)\[\e[00m\]$\n"
