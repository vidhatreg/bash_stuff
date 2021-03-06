# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# save each command right after execution
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

# some more ls aliases
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# basic calculator
alias calc=perl\ \-ne\ \'print\ eval\(\$_\)\.\"\\n\"\'

# less man page colors
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'

function mkcd() { mkdir "$1" && cd "$1"; }
function calc(){ awk "BEGIN{ print $* }" ;}
function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }
function mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }
function mkmine() { sudo chown -R ${USER} ${1:-.}; }
function rot13 () { echo "$@" | tr a-zA-Z n-za-mN-ZA-M; }
function :h () {  vim -c "silent help $@" -c "only"; }
function gril () { grep -rl "$@" *; }
function grepword () { grep -Hnr "$@" *; }
function vimf () { vim -c "ScratchFind" -c "only"; }
function vimg () { vim -c "ScratchFind 'grep -rl \"$@\" *'" -c "only"; }
function vfind () { vim -p $(find . -name '$@'); }

function sendkey () {
    if [ $# -eq 1 ]; then
        local key=""
        if [ -f ~/.ssh/id_dsa.pub ]; then
            key=~/.ssh/id_dsa.pub
        elif [ -f ~/.ssh/id_rsa.pub ]; then
            key=~/.ssh/id_rsa.pub
        else
            echo "No public key found" >&2
            return 1
        fi
        ssh $1 'cat >> ~/.ssh/authorized_keys' < $key
    fi
}

#Different colors for remote server
if [ -z "$SSH_TTY" ]; then
    PS1="\[\033[36m\]\u\[\033[37m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$ "
else
    PS1="\[\033[35m\]\u\[\033[37m\]@\[\033[31m\]\h:\[\033[34;1m\]\w\[\033[m\]$ "
fi

# prevent ^S and ^Q doing XON/XOFF
stty -ixon

if [ -e /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -e /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -e $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi


#Leon3
# grmon : JTAG debug tool
export PATH=/opt/leon/grmon/linux/bin:$PATH
# sparc-linux- : Linux Cross compiler
export PATH=/opt/leon/sparc-linux/usr/bin:$PATH
# mklinuximg : Make bootable linux image (PATCHED TO WORK WITH NEW KERNEL)
export PATH=/opt/leon/mklinuximg-2.6.36-2.0.3:$PATH
# mkprom2 : Make PROM bootable image
export PATH=/opt/leon/mkprom2:$PATH

alias grlib="cd ~/repo/esp/grlib-vc707"

export PATH=/opt/sparc-elf-4.4.2/bin:$PATH


alias tools_env="source /opt/cad/scripts/tools_env.sh"

#TAR ALIAS
alias tartar="tar -cf"
alias untartar="tar -xf"
alias targz="tar -pczf"
alias untargz="tar xfz"
alias tarbz2="tar -pcjf"
alias untarbz2="tar xjf"

alias code="emacs -nw"

