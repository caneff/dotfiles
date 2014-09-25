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

# expand aliased paths when tab completing
shopt -s direxpand

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

export TERMINAL="rxvt-unicode"
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


export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH


export JAR=/usr/local/buildtools/java/jdk-64/bin/jar
export JAVA=/usr/local/buildtools/java/jdk-64/bin/java
export JAVAC=/usr/local/buildtools/java/jdk-64/bin/javac
export JAVAH=/usr/local/buildtools/java/jdk-64/bin/javah
export JAVA_HOME=/usr/local/buildtools/java/jdk-64/jre
export JAVA_LD_LIBRARY_PATH=${JAVA_HOME}/lib/amd64/server:${JAVA_HOME}/lib/amd64
export JAVA_LIBS="-L${JAVA_HOME}/lib/amd64/server -L${JAVA_HOME}/lib/amd64 -L${JAVA_HOME}/../lib/amd64 -ljvm"
export JAVA_CPPFLAGS="-I${JAVA_HOME}/../include -I${JAVA_HOME}/../include/linux"
export R_JAVA_LD_LIBRARY_PATH=${JAVA_HOME}/lib/amd64/server:${JAVA_HOME}/lib/amd64





# Stuff for specific configs (like work stuff).
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
if [ -f ~/.bash_aliases_local ]; then
    source ~/.bash_aliases_local
fi

# undistract-me stuff
LONG_RUNNING_PREEXEC_LOCATION=$HOME/git/undistract-me/preexec.bash
. ~/git/undistract-me/long-running.bash
notify_when_long_running_commands_finish_install






# Lines added by the Vim-R-plugin command :RpluginConfig (2014-Aug-18 07:44):
# Change the TERM environment variable (to get 256 colors) and make Vim
# connecting to X Server even if running in a terminal emulator (to get
# dynamic update of syntax highlight and Object Browser):
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]
then
    export TERM=xterm-256color
    export HAS_256_COLORS=yes
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi
if [ "x$DISPLAY" != "x" ]
then
    alias vim="gvim --servername VIM"
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color gvim --servername VIM $@" ; }
    else
        function tvim(){ tmux new-session "gvim --servername VIM $@" ; }
    fi
else
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color gvim $@" ; }
    else
        function tvim(){ tmux new-session "gvim $@" ; }
    fi
fi
