if [[ $OSTYPE == darwin* ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color -F --time-style=long-iso --group-directories-first'
fi

alias sl='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ll -A'
alias em='emacs -nw'
alias history='history -t "%F %T"'
alias grep='grep --color=auto'
alias tf='terraform'

# in ubuntu, bat is named batcat
if type batcat > /dev/null 2>&1; then
  alias bat='batcat'
fi

function gitzip() {
    dir_name=`basename \`git rev-parse --show-toplevel\``
    echo $dir_name
        git archive -o ${dir_name}\.zip HEAD
}
