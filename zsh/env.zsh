export AWS_PROFILE=default
export EDITOR=emacs
export GOPATH=$HOME/go

if [[ $OSTYPE == darwin* ]]; then
  export PATH=$PATH:/opt/homebrew/bin
fi

path=(
  "$HOME/.local/bin"
  "/usr/local/go/bin"
  "$path[@]"
)
