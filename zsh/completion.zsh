# initialize completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -C

# style
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' group-name ''
if [[ $OSTYPE == Linux* ]]; then
  zstyle ':completion:*' special-dirs true
  zstyle ':completion:*' list-colors `dircolors`
fi

setopt auto_param_keys
setopt correct

# kube
which minikube >/dev/null 2>&1 && source <(minikube completion zsh) && source <(minikube kubectl completion zsh)
which kn >/dev/null 2>&1 && source <(kn completion zsh)
which helm >/dev/null 2>&1 && source <(helm completion zsh)

# awscli
autoload bashcompinit && bashcompinit
if test -e /usr/local/bin/aws_completer; then
  complete -C '/usr/local/bin/aws_completer' aws
else
  echo "\e[1;31m[warn]\e[m aws_completer not found in /usr/local/bin/"
fi

# npm
if which npm >/dev/null 2>&1; then
  source <(npm completion)
fi
