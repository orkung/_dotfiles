FUNCNEST=1000

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -t 0 && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
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
plugins=(git aws docker autojump fzf-zsh-plugin zsh-completions zsh-history-substring-search zsh-256color zsh-syntax-highlighting)
#plugins=(git fzf-zsh-plugin nvm autojump zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search zsh-256color)

source "$ZSH/oh-my-zsh.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

load-nvmrc() {
  local nvmrc_path node_version
  nvmrc_path="$(nvm_find_nvmrc 2>/dev/null)"

  if [[ -n "$nvmrc_path" ]]; then
    node_version="$(<"$nvmrc_path")"
    nvm use --silent "$node_version" >/dev/null
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down
#bindkey -M viins '^P' history-substring-search-up
#bindkey -M viins '^N' history-substring-search-down

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
alias dedockify="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm mrhavens/dedockify"
alias k="kubectl"
alias kx="kubectl exec -it"
alias kgn="kubectl get nodes -o wide"
alias kgns="kubectl get ns"
alias kcl="kubectl config get-contexts"
alias kcc="kubectl config current-context"
alias kbgp="kubectl get pods -o wide -n kube-system"
alias kbgd="kubectl get deploy -o wide -n kube-system"
alias kbgsvc="kubectl get svc -o wide -n kube-system"
alias kbgpall="kubectl get pods -o wide --all-namespaces"
alias kbgdall="kubectl get deploy -o wide --all-namespaces"
alias kbgsvcall="kubectl get svc -o wide --all-namespaces"
alias kgnall="kubectl get nodes -o wide"
#vauld() { kubectl exec -n vault vault-0 -- vault "$@"; }
klogs() { kubectl logs -f --tail=100 -n "$1" "$2" "${@:3}"; }
kexec() {
  local namespace pod
  namespace="$1"
  pod="$2"
  shift 2
  if (( $# == 0 )); then
    kubectl exec -it -n "$namespace" "$pod" -- /bin/bash
  else
    kubectl exec -it -n "$namespace" "$pod" -- "$@"
  fi
}
kgp() { kubectl get pods -o wide -n "$1"; }
kgs() { kubectl get svc -o wide -n "$1"; }
kgd() { kubectl get deploy -o wide -n "$1"; }
kctx() { kubectl config use-context "$1"; }
kcu() { kubectl config use-context "$1"; }
kcd() { builtin cd "$HOME/kubeconfigs" && kubectl config use-context "$1" && builtin cd - >/dev/null; }
kga() { kubectl get all -o wide -n "$1"; }
kdel() { kubectl delete -n "$1" "$2" "${@:3}"; }
kdp() { kubectl describe pod -n "$1" "$2"; }
kdd() { kubectl describe deploy -n "$1" "$2"; }
kds() { kubectl describe svc -n "$1" "$2"; }
kdn() { kubectl describe node "$1"; }
kdi() { kubectl describe ing -n "$1" "$2"; }
kcp() { kubectl config set-context --current --namespace="$1"; }
kpf() { kubectl port-forward -n "$1" "$2" "$3:$4"; }
kclp() { kubectl config get-contexts | grep -- "$1"; }
kdelp() { kubectl delete pod -n "$1" "$2"; }
kdr() { kubectl drain "$1" --ignore-daemonsets --delete-local-data; }
kdu() { kubectl uncordon "$1"; }
kbdp() { kubectl describe pod -n kube-system "$1"; }
kbdd() { kubectl describe deploy -n kube-system "$1"; }
kbdsvc() { kubectl describe svc -n kube-system "$1"; }
kbi() { kubectl describe ing -n kube-system "$1"; }
kbdpall() { kubectl describe pod --all-namespaces "$1"; }
kbddall() { kubectl describe deploy --all-namespaces "$1"; }
kbdsvcall() { kubectl describe svc --all-namespaces "$1"; }
kbiall() { kubectl describe ing --all-namespaces "$1"; }
HISTFILE="$HOME/.zsh_history"
export DIR_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/dir_history"
HISTSIZE=100000
SAVEHIST=100000
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt APPEND_HISTORY         # Append to history rather than replacing it.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_FCNTL_LOCK        # Safer history writes with concurrent shells.
unsetopt HIST_BEEP            # Avoid audible bell on missing history entries.
autoload -Uz add-zsh-hook
[ -d "${DIR_HISTFILE:h}" ] || mkdir -p "${DIR_HISTFILE:h}"

__dir_history_log() {
    emulate -L zsh

    local command_text="$1"
    command_text="${command_text%$'\n'}"

    [[ -z "${command_text//[[:space:]]/}" ]] && return 0
    [[ "$command_text" == ' '* ]] && return 0

    command_text="${command_text//$'\n'/ ↩ }"
    command_text="${command_text//$'\t'/    }"

    print -r -- "${EPOCHSECONDS}"$'\t'"${PWD}"$'\t'"${command_text}" >>| "$DIR_HISTFILE"
}

add-zsh-hook zshaddhistory __dir_history_log
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [[ -t 0 ]]; then
  bindkey -v
fi
export KEYTIMEOUT=1
# bindkey '^d' exit

zl() {
    ~/bin/zargan.py "$@" 2>/dev/null | head -n 10
}

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
#export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

export INTELLI_HOME="$HOME/.local/share/intelli-shell"
typeset -U path PATH
path=(
  "$HOME/.rvm/gems/ruby-2.5.0@task-web/bin"
  /usr/local/bin
  "$HOME/bin"
  "$HOME/.rvm/gems/ruby-2.7.1/bin"
  "$HOME/.rvm/bin"
  "$HOME/.pyenv/bin"
  "$HOME/.local/bin"
  "$HOME/.pyenv/versions/3.9.0/bin"
  "$HOME/.pyenv/versions/2.7.18/bin"
  "$HOME/.cargo/bin"
  "$HOME/Downloads/crc-linux-1.25.0-amd64"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "$HOME/go/bin"
  "$JAVA_HOME/bin"
  "$INTELLI_HOME/bin"
  "$HOME/.vscode-server/extensions/openai.chatgpt-0.4.79-linux-x64/bin/linux-x86_64"
  $path
)
export PATH

[[ -r "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"
[[ -r "$HOME/.zsh.secrets" ]] && source "$HOME/.zsh.secrets"

[[ -r /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh
#alias tmux="TERM=xterm-256color /usr/bin/tmux"
#alias tmux="TERM=screen-256color-bce tmux"
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

taskaddlong() {
    task add +next pro:$1 pri:$2 +$3 due:$4 scheduled:$5 wait:$6 $7
}

taskaddshort() {
    task add pro:$1 pri:$2 +$3 due:$4 $5
}
alias reload="source ~/.zshrc"

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
tur() { curl -s "https://tureng.com/en/turkish-english/$(echo "$@" | tr [A-Z] [a-z])" | elinks -dump | sed '1,60d;/Pronunciation in context/q' | less; }
tdk() { curl -s "http://www.tdk.gov.tr/index.php?option=com_gts&view=gts&kelime=$*" | elinks -dump | sed '1,65d;/kez söz arandı./q' | less; }
#et() { sdcv -nu "Babylon English-Turkish" "$@" | sed -e "/^-->.*$/d" -e "s/\r\r/\r/" -e "s/<font.*\">/$(printf "\e[34m")/" -e "s/<\/font>/$(printf "\e[00m")/"; }
#alias te="sdcv -cu Turkish-English"
function ta_proj() { echo "$2" | vipe | tr '\n' '\0' | xargs -0 -n1 -t task add "project:$1"; }

taskaddworksupport() {
    task add pro:work.support pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworksupport() {
    task add pro:work.support pri:$1 +$2 due:$3 $4
}
alias tawsu=taskaddworksupport
alias taswsu=taskaddshortworksupport

taskaddworkmisc() {
    task add pro:work.misc pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkmisc() {
    task add pro:work.misc pri:$1 +$2 due:$3 $4
}
alias tawmi=taskaddworkmisc
alias taswmi=taskaddshortworkmisc

taskaddworkdev() {
    task add pro:work.dev pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkdev() {
    task add pro:work.dev pri:$1 +$2 due:$3 $4
}
alias tawde=taskaddworkdev
alias taswde=taskaddshortworkdev

taskaddworkops() {
    task add pro:work.ops pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkops() {
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
taskaddworkrefund() {
    task add pro:work.refund pri:$1 +$2 due:$3 scheduled:$4 $5
}
taskaddshortworkrefund() {
    task add pro:work.refund pri:$1 +$2 due:$3 $4
}
alias tawref=taskaddworkrefund
alias taswref=taskaddshortworkrefund
#alias oc="/mnt/c/Users/Kafein/.crc/bin/oc/oc.exe"
alias toast='powershell.exe -command New-BurntToastNotification'
alias tp='trans -p'
#eval "$(register-python-argcomplete pipx)"
export HOST_IP="$(ip route | awk '/^default/{print $3}')"
export PULSE_SERVER="tcp:$HOST_IP"
#export DISPLAY="$HOST_IP:0.0"
alias gacp="git add -A && git commit -m "." && git push"
alias g="git"
alias gp="git push"
alias ga="git add -A"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate --all"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gpl="git pull"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --stat"
alias glgp="git log --pretty=format:'%h - %an, %ar : %s'"
alias gs="git status"
function entr() {
    trans :tr "$1" | less
}
function tren() {
    trans :en "$1" | less
}

function enen() {
    trans :en "$1" | less
}

export FZF_BASE="${FZF_BASE:-/usr/bin/fzf}"
#eval $(crc oc-env)
alias nvim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0 |grep -E "state|to\ full|percentage"'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs newline)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load)

#eval "$(atuin init zsh)"
#source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function entr() {
    trans :tr "$1" | head -n 25
}
function tren() {
    trans :en "$1" | head -n 25
}

function enen() {
    trans :en "$1" | head -n 25
}

# Running under WSL (Windows Subsystem for Linux)?
if uname -r | egrep -q '*microsoft*'; then
    WSL_running=true
else
    WSL_running=false
fi

alias lh="ls -ld .?*"
alias lr="ls -alhtr"
alias random="tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo"
source $HOME/zsh.include.sh

#source $HOME/.config/broot/launcher/bash/br

# eval "$(gh copilot alias -- zsh)"
alias neo='source $(pwd)/venv/bin/activate && python3 $(pwd)/main.py'
#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
# source <(carapace _carapace)

#socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null head -1)
#export VSCODE_IPC_HOOK_CLI=$(ls -tr /tmp/vscode-ipc-* | tail -n 1)
#export VSCODE_IPC_HOOK_CLI=`ls -tr /mnt/wslg/runtime-dir/vscode-ipc-* | tail -n 1`
#export VSCODE_IPC_HOOK_CLI=$(lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
#export VSCODE_IPC_HOOK_CLI=${socket}

#eval "$(starship init zsh)"
#export FUNCNEST=100

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
setopt NULL_GLOB
autoload -Uz compinit && compinit
#compdef k9s
compdef _k9s k9s

# zsh completion for k9s                                  -*- shell-script -*-

__k9s_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_k9s()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace keepOrder
    local -a completions

    __k9s_debug "\n========= starting completion logic =========="
    __k9s_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __k9s_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __k9s_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., k9s -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __k9s_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __k9s_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __k9s_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __k9s_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __k9s_debug "No directive found.  Setting do default"
        directive=0
    fi

    __k9s_debug "directive: ${directive}"
    __k9s_debug "completions: ${out}"
    __k9s_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __k9s_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __k9s_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __k9s_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __k9s_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __k9s_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __k9s_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]; then
        __k9s_debug "Activating keep order."
        keepOrder="-V"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __k9s_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __k9s_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __k9s_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __k9s_debug "Calling _describe"
        if eval _describe $keepOrder "completions" completions $flagPrefix $noSpace; then
            __k9s_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __k9s_debug "_describe did not find completions."
            __k9s_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __k9s_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __k9s_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

POWERLEVEL9K_MODE='ascii'
# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_k9s" ]; then
    _k9s
fi

#tmux-git-autofetch() {(/root/.tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)}
#add-zsh-hook chpwd tmux-git-autofetch
# VS Code wrapper to pass all arguments correctly
code() {
  local bin="/root/.vscode-server/bin/61b3d0ab13be7dda2389f1d3e60a119c7f660cc3/bin/remote-cli/code"
  if [[ $# -eq 0 ]]; then
    "$bin" .
  else
    "$bin" "$@"
  fi
}

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
## Fix VS Code IPC socket for tmux sessions
#if [ -d "/tmp" ]; then
#  export VSCODE_IPC_HOOK_CLI=$(ls -tr /tmp/vscode-ipc-* 2>/dev/null | tail -n 1)
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
#fi
## Fix VS Code IPC socket for tmux sessions
#if [ -d "/mnt/wslg/runtime-dir" ]; then
#  export VSCODE_IPC_HOOK_CLI=$(ls -tr /mnt/wslg/runtime-dir/vscode-ipc-* 2>/dev/null | tail -n 1)
#fi
# Prompt enhancer using Claude API
enhance() {
    local question="$*"
    echo "Enhancing: $question"
    echo ""

    # Call Claude API (requires anthropic-cli or similar)
    # Or just remind yourself to ask properly:
    echo "Consider adding:"
    echo "- Environment/tech stack"
    echo "- Current state vs goal"
    echo "- Constraints (time/budget/skills)"
    echo "- Expected output format"
    echo ""
    echo "Enhanced template:"
    echo "\"I need to $question"
    echo ""
    echo "Environment: [YOUR_STACK]"
    echo "Requirements: [WHAT_YOU_NEED]"
    echo "Constraints: [LIMITATIONS]"
    echo "Please provide: [EXPECTED_OUTPUT]\""
}

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
alias bat=batcat


# Start SSH agent automatically
if [[ -t 0 && -z "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/kafein-ssh
  ssh-add ~/.ssh/id_ed25519_orkung
  ssh-add ~/.ssh/id_ed25519
fi
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
. "/root/.deno/env"

# Auto-update VS Code IPC socket for tmux compatibility
# This ensures Antigravity works in tmux by only picking sockets with active listeners
if [ -d "/mnt/wslg/runtime-dir" ]; then
  # Find the newest socket that actually has a listener
  active_socket=$(ss -xl 2>/dev/null | grep -o '/mnt/wslg/runtime-dir/vscode-ipc-.*\.sock' | tail -n 1)
  if [ -n "$active_socket" ]; then
    export VSCODE_IPC_HOOK_CLI="$active_socket"
  fi
fi

# Add to ~/.zshrc
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# Add to ~/.zshrc
alias awsp='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
alias awsr='export AWS_REGION=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text | tr "\t" "\n" | fzf)'
alias awswho='aws sts get-caller-identity'

# Add to ~/.zshrc
awsprofile() {
  if [ -z "$1" ]; then
    echo "Current profile: ${AWS_PROFILE:-default}"
    echo "Available profiles:"
    aws configure list-profiles
  else
    export AWS_PROFILE=$1
    echo "Switched to profile: $1"
  fi
}
alias awslogin='aws sso login --profile ${AWS_PROFILE:-default}'

awsmfa() {
  aws sts get-session-token --serial-number $1 --token-code $2
}

# --- Zsh Integration (using ZLE - Zsh Line Editor) ---
# https://zsh.sourceforge.io/Guide/zshguide04.html
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html

# IntelliShell
export INTELLI_SEARCH_HOTKEY='^ '        # Ctrl-Space
export INTELLI_VARIABLE_HOTKEY='^X'      # Ctrl-X
export INTELLI_BOOKMARK_HOTKEY='^G'      # Ctrl-G
export INTELLI_FIX_HOTKEY='^F'           # Ctrl-F
export INTELLI_SKIP_ESC_BIND=1

alias is="intelli-shell"
eval "$(intelli-shell init zsh)"
source ~/.local/share/intelli-shell/bin/intelli-shell.sh

# Override the generated widgets with vi-mode aware bindings and a friendlier
# bookmark flow: save the current command, or fall back to the last history item.
function _intelli_exec {
  local temp_result_file
  temp_result_file=$(mktemp)

  BUFFER=""
  zle -I

  intelli-shell --skip-execution --file-output "$temp_result_file" "$@"
  local exit_status=$?

  if [[ ! -s "$temp_result_file" ]]; then
    rm -f "$temp_result_file" 2>/dev/null
    return $exit_status
  fi

  local -a lines
  lines=("${(f)$(<"$temp_result_file")}")
  rm -f "$temp_result_file" 2>/dev/null

  local out_status="${lines[1]}"
  local action=""
  local command=""

  if ((${#lines[@]} > 1)); then
    action="${lines[2]}"
  fi
  if ((${#lines[@]} > 2)); then
    command="${(F)lines[3,-1]}"
  fi

  if [[ "$out_status" != "DIRTY" && $exit_status -eq 0 ]]; then
    zle .redisplay
  fi

  if [[ "$action" == "REPLACE" ]]; then
    BUFFER="$command"
    zle .end-of-line
  elif [[ "$action" == "EXECUTE" ]]; then
    BUFFER="$command"
    zle .accept-line
  fi
}

function _intelli_search {
  _intelli_exec search -i "$BUFFER"
}

function _intelli_save {
  local command_to_save="$BUFFER"

  if [[ -z "${command_to_save//[[:space:]]/}" ]]; then
    command_to_save="$(fc -ln -1)"
    command_to_save="${command_to_save#"${command_to_save%%[![:space:]]*}"}"
  fi

  _intelli_exec new -i "$command_to_save"
}

function _intelli_variable {
  _intelli_exec replace -i "$BUFFER"
}

function _intelli_fix {
  local hist
  hist=$(fc -l -n -5)
  _intelli_exec fix --history "$hist" "$BUFFER"
}

zle -N _intelli_search
zle -N _intelli_save
zle -N _intelli_variable
zle -N _intelli_fix

bindkey -M viins '^ ' _intelli_search
bindkey -M vicmd '^ ' _intelli_search
bindkey -M viins '^G' _intelli_save
bindkey -M vicmd '^G' _intelli_save
bindkey -M viins '^X' _intelli_variable
bindkey -M vicmd '^X' _intelli_variable
bindkey -M viins '^F' _intelli_fix
bindkey -M vicmd '^F' _intelli_fix

# VS Code shell integration
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  local _integration_path
  _integration_path=$(code --locate-shell-integration-path zsh 2>/dev/null)
  if [[ -n "$_integration_path" && -f "$_integration_path" ]]; then
    source "$_integration_path"
  fi
fi

# # Define key bindings, using defaults if environment variables are not set
# intelli_search_key="${INTELLI_SEARCH_HOTKEY:-^@}"
# intelli_bookmark_key="${INTELLI_BOOKMARK_HOTKEY:-^b}"
# intelli_variable_key="${INTELLI_VARIABLE_HOTKEY:-^l}"
# intelli_fix_key="${INTELLI_FIX_HOTKEY:-^x}"
#
# # Helper function to execute intelli-shell and update the ZLE buffer
# function _intelli_exec {
#   local temp_result_file=$(mktemp)
#
#   # Clear the buffer and invalidate to force a redraw of the line
#   BUFFER=""
#   zle -I
#
#   # Run intelli-shell
#   intelli-shell --skip-execution --file-output "$temp_result_file" "$@"
#   local exit_status=$?
#
#   # If the output file is missing or empty, there's nothing to process (likely a crash)
#   if [[ ! -s "$temp_result_file" ]]; then
#     rm -f "$temp_result_file" 2>/dev/null
#     return $exit_status
#   fi
#
#   # Read the file content and parse it
#   local -a lines
#   lines=("${(f)$(<"$temp_result_file")}")
#   rm -f "$temp_result_file" 2>/dev/null
#   local out_status="${lines[1]}"
#   local action=""
#   local command=""
#   if ((${#lines[@]} > 1)); then
#     action="${lines[2]}"
#   fi
#   if ((${#lines[@]} > 2)); then
#     command="${(F)lines[3,-1]}"
#   fi
#
#   # Determine whether to start a new prompt line
#   if [[ "$out_status" == "DIRTY" || $exit_status -ne 0 ]]; then
#     # Nothing to do, ZLE will redraw the prompt on the next line (because of `zle -I` above)
#   else
#     # For any clean action, stay on the same line.
#     zle .redisplay
#   fi
#
#   # Determine the content of the buffer
#   if [[ "$action" == "REPLACE" ]]; then
#     BUFFER="$command"
#     zle .end-of-line
#   elif [[ "$action" == "EXECUTE" ]]; then
#     BUFFER="$command"
#     zle .accept-line
#   fi
# }
#
# # ZLE widget function for searching
# function _intelli_search {
#   _intelli_exec search -i "$BUFFER"
# }
#
# # ZLE widget function for saving/bookmarking
# function _intelli_save {
#   _intelli_exec new -i "$BUFFER"
# }
#
# # ZLE widget function for variable replacement
# function _intelli_variable {
#   _intelli_exec replace -i "$BUFFER"
# }
#
# # ZLE widget function for fixing commands
# function _intelli_fix {
#   local hist
#   hist=$(fc -l -n -5)
#   _intelli_exec fix --history "$hist" "$BUFFER"
# }
#
# # Bind ESC to kill the whole line if not skipped (only in insert mode for vi users)
# if [[ "${INTELLI_SKIP_ESC_BIND:-0}" == "0" ]]; then
#   # bindkey -M viins '\e' kill-whole-line
# fi
#
# # Register the functions as ZLE widgets
# zle -N _intelli_search
# zle -N _intelli_save
# zle -N _intelli_variable
# zle -N _intelli_fix
#
# # Bind the keys to the widgets in both viins and vicmd keymaps
# bindkey -M viins "$intelli_search_key" _intelli_search
# bindkey -M vicmd "$intelli_search_key" _intelli_search
#
# bindkey -M viins "$intelli_bookmark_key" _intelli_save
# bindkey -M vicmd "$intelli_bookmark_key" _intelli_save
#
# bindkey -M viins "$intelli_variable_key" _intelli_variable
# bindkey -M vicmd "$intelli_variable_key" _intelli_variable
#
# bindkey -M viins "$intelli_fix_key" _intelli_fix
# bindkey -M vicmd "$intelli_fix_key" _intelli_fix
#
# # Export the execution prompt variable
# export INTELLI_EXEC_PROMPT="$(print -r -- "$PS2" | sed 's/%{//g; s/%}//g')"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
export BROWSER=wslview
fpath=($fpath ~/.zsh/completion)
