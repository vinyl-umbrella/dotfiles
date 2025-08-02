export AWS_PROFILE=default
export AWS_REGION=ap-northeast-1
export AWS_SDK_LOAD_CONFIG=1
export EDITOR=emacs
export GOPATH=$HOME/go

if [[ $OSTYPE == darwin* ]]; then
  export PATH=$PATH:/opt/homebrew/bin
fi

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$GOPATH/bin"
  "/usr/local/go/bin"
  "$path[@]"
)
