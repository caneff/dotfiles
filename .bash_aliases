alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'
alias ll='ls -alh --color=auto'
alias top='htop'
alias grep='grep --color=auto'

alias dtupdate="svn up --depth='infinity' ~/datatable/datatable/;rm -rf ${R_LIBS_USER}/00LOCK/; rm -rf ${R_LIBS_USER}/00LOCK-pkg; MAKEFLAGS='CFLAGS=-O0\ -g\ -Wall\ -pedantic' R CMD INSTALL --library=${R_LIBS_USER} ~/datatable/datatable/pkg;"
alias ssh='ssh -YC'

alias vi="vim -g $@ &> /dev/null"

alias xm="xmodmap .Xmodmap"

