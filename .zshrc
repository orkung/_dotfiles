# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/orkun/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
ISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
bindkey -v

zl(){
    ~/bin/zargan.py $@ 2>/dev/null | head -10
}
export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'
export PATH="${HOME}/.rvm/gems/ruby-2.5.0@task-web:/usr/local/bin:${HOME}/bin:${HOME}/.rvm/gems/ruby-2.7.1/bin:${HOME}/.rvm/bin:${HOME}/.pyenv/bin:${HOME}/.local/bin:${HOME}/.pyenv/versions/3.9.0/bin:${HOME}/.pyenv/versions/2.7.18/bin:${HOME}/.local/lib/python2.7/site-packages:${HOME}/.cargo/bin:${HOME}/Downloads/crc-linux-1.25.0-amd64:/home/orkun/.crc/bin/oc:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

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
alias t="/bin/task"
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
#export DISPLAY="$HOST_IP:0.0"
alias gacp="git add -A && git commit -m "." && git push"
function entr() {
trans :tr "$1" |less
}
function tren() {
trans :en "$1" |less
}

function enen() {
trans :en "$1" |less
}

export FZF_DEFAULT_COMMAND='fd'
xmodmap ~/.Xmodmap
eval $(crc oc-env)
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0 |grep -E "state|to\ full|percentage"'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs newline)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load)
