if [[ $OSTYPE == darwin* ]]; then
  export PATH=$PATH:/opt/homebrew/bin
fi

path=(
  "$HOME/.local/bin"
  "/usr/local/go/bin"
  "$path[@]"
)


export WIN_HOME=/mnt/c/Users/j
