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
alias tf='terraform'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias c='code'
alias kubectl="minikube kubectl --"

# in ubuntu, bat is named batcat
if type batcat > /dev/null 2>&1; then
  alias bat='batcat'
fi

function gitzip() {
    dir_name=`basename \`git rev-parse --show-toplevel\``
    echo $dir_name
        git archive -o ${dir_name}\.zip HEAD
}

function psgrep() {
    ps aux | head -n 1;
    ps aux | grep $* | grep -v "ps -auxww" | grep -v grep;
}
