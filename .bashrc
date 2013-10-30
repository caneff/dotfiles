# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=1000000
export HISTSIZE=100000
shopt -s histappend

if [ "$TERM" == "screen" ]; then
  PROMPT_COMMAND='echo -ne "\033k${USER} <at> ${HOSTNAME}:${PWD/#$HOME/'~'}\033\\"'
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

export EDITOR="vi -g -f"
export INPUTRC="~/.inputrc"

export R_LIBS_USER="~/R/x86_64-pc-linux-gnu-library/2.12"
export R_LIBS_SITE=""

# Prevent R from taking too much memory and freezing the system.
ulimit -v 34000000000

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export R_HISTFILE=~/.Rhistory

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Stuff for specific configs (like work stuff).
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
if [ -f ~/.bash_aliases_local ]; then
    source ~/.bash_aliases_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# undistract-me stuff
LONG_RUNNING_PREEXEC_LOCATION=$HOME/git/undistract-me/preexec.bash
. ~/git/undistract-me/long-running.bash
notify_when_long_running_commands_finish_install
