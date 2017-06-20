echo "This is bashrc."

gvim() {
	if [ "$1" = "" ]; then
		open -a MacVim
        else
		if [ "$2" = "-n" ]; then 
			touch "$1"
		fi
		open -a MacVim "$1"
        fi
       	return 0
}

alias ls='ls -G'
# alias gvim='open -a MacVim'

export PS1="\033[96m\t \u:\w\033[0m \n$ "
