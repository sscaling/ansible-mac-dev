if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.profile ]; then
    source ~/.profile
fi

export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\]\w\[$(tput setaf 4)\] \\$ \[$(tput sgr0)\]"

#golang installed via brew
export PATH=$PATH:/usr/local/opt/go/libexec/bin


