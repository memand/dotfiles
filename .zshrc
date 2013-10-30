# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing: %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=3
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e errors found, choose correction:'
zstyle ':completion:*' select-prompt '%SScrolling %l matches: current selection at %p%s'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/memand/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# {{{ environment settings

# Set term to 256 colors
case $TERM in xterm|rxvt-unicode|screen) TERM="$TERM-256color";
    export TERM;
esac;

# Set dircolors so ls --color=auto matches the solarized-dark theme
# https://github.com/seebi/dircolors-solarized
eval `dircolors ~/.dir_colors`

REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
WATCH=notme         # Report any login/logout of other users
WATCHFMT='%n %a %l from %m at %T.'

export EDITOR='vim'
export GIT_EDITOR=$EDITOR
export LESS='-imJMWR'
export PAGER="less $LESS"
export MANPAGER=$PAGER
export GIT_PAGER=$PAGER

# set up for virtualenv for python
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

# Silence Wine debugging output (why isn't this a default?)
export WINEDEBUG=-all

# }}}
# {{{ completions

# Remote sys autocomplete
zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'

# }}}
# {{{ prompt and theme

# Set up prompt
if [[ ! -n "$ZSHRUN" ]]; then
    source $HOME/.zsh_shouse_prompt
fi

# }}}
# {{{ aliases

alias ls='ls -F --color'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ll -A'
alias lls='ll -Sr'

alias less='less -imJMW'
alias cls='clear' # note: ctrl-L under zsh does something similar
alias df='df -h'

alias ts='chmod 644 /home/memand/Downloads/*.torrent;\
          chown :torrent /home/memand/Downloads/*.torrent;\
          scp /home/memand/Downloads/*.torrent etcph:../downloads/watch;\
          rm /home/memand/Downloads/*.torrent'

alias mf='sudo modprobe -r psmouse; sleep 5; sudo modprobe psmouse'

alias eve='optirun wine explorer /desktop=eveA,1920x1080 "c:\program files\ccp\eve\eve.exe"'

# }}}

# Miscellaneous Functions:

# ..(), ...() for quickly changing $CWD {{{1
# http://www.shell-fu.org/lister.php?id=769

# Go up n levels:
# .. 3
function .. (){
    local arg=${1:-1};
    local dir=""
    while [ $arg -gt 0 ]; do
        dir="../$dir"
        arg=$(($arg - 1));
    done
    cd $dir >&/dev/null
}

# Go up to a named dir
# ... usr
function ... (){
    if [ -z "$1" ]; then
        return
    fi
    local maxlvl=16
    local dir=$1
    while [ $maxlvl -gt 0 ]; do
        dir="../$dir"
        maxlvl=$(($maxlvl - 1));
        if [ -d "$dir" ]; then
            cd $dir >&/dev/null
        fi
    done
}

# make a dir and cd into that dir
# take dirname
function take (){
    mkdir $1
    cd $1
}
# }}}
