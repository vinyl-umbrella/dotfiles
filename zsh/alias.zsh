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


function base91() {
  local alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#\$%&()*+,./:;<=>?@[]^_\`{|}~\""
  local input="$1"

  # If no input provided, read from stdin
  if [[ -z "$input" ]]; then
    input=$(cat)
  fi

  # Base91 encode
  local v=0
  local b=0
  local n=0
  local output=""

  # Convert input to bytes
  for ((i=0; i<${#input}; i++)); do
    local char="${input:$i:1}"
    local byte=$(printf '%d' "'$char")

    b=$((b | (byte << n)))
    n=$((n + 8))

    while [[ $n -gt 13 ]]; do
      v=$((b & 8191))
      if [[ $v -gt 88 ]]; then
        b=$((b >> 13))
        n=$((n - 13))
      else
        v=$((b & 16383))
        b=$((b >> 14))
        n=$((n - 14))
      fi
      output+="${alphabet:$((v % 91)):1}${alphabet:$((v / 91)):1}"
    done
  done

  if [[ $n -gt 0 ]]; then
    output+="${alphabet:$((b % 91)):1}"
    if [[ $n -gt 7 ]] || [[ $b -gt 90 ]]; then
      output+="${alphabet:$((b / 91)):1}"
    fi
  fi

  echo "$output"
}
