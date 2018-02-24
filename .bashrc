echo "This is bashrc."

alias ls='ls -G'
alias gview='gvim -R'

export PS1="\033[96m\t \u:\w\033[0m \n$ "

set -o emacs
