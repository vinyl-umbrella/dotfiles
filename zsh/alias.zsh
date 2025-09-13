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
alias sjis2utf8='iconv -f SHIFT_JIS -t UTF-8'
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


function ecrp() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: ecrp <aws-profile> <ecr-url>"
    return 1
  fi

  local profile="$1"
  local ecr_url="$2"
  local region="${AWS_REGION:-ap-northeast-1}"

  aws ecr get-login-password --region "$region" --profile "$profile" | docker login --username AWS --password-stdin "$ecr_url"

  docker pull "$ecr_url"
}

function imgx() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: imgx <image>"
    return 1
  fi

  local image="$1"
  local container_id=$(docker create "$image" 2>/dev/null)

  # sanitize
  local safe_image
  safe_image=$(printf '%s' "$image" | sed 's#[/:]#_#g')

  output_dir="${safe_image}_$(date +%Y%m%d%H%M%S)"
  mkdir -p "$output_dir"

  # Stream export directly into tar extraction
  docker export "$container_id" | tar -x -C "$output_dir"

  # Successful cleanup (trap will still attempt but it's fine)
  docker rm "$container_id" >/dev/null 2>&1
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
