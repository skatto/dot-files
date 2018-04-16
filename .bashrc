echo "This is bashrc."

alias ls='ls -G'
alias gview='gvim -R'
alias xvim='open -a Xcode'

export PS1="\033[96m\t \u:\w\033[0m \n$ "

set -o emacs
