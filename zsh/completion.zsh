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
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt LIST_TYPES
setopt auto_param_keys
setopt correct

# kube
which minikube > /dev/null 2>&1 && source <(minikube completion zsh) && source <(minikube kubectl completion zsh)
which kn > /dev/null 2>&1 && source <(kn completion zsh)
which helm > /dev/null 2>&1 && source <(helm completion zsh)

# gh
which gh > /dev/null 2>&1 && source <(gh completion -s zsh)

# docker
which docker > /dev/null 2>&1 && source <(docker completion zsh)

# npm
which npm > /dev/null 2>&1 && source <(npm completion)

# uv
which uv > /dev/null 2>&1 && source <(uv generate-shell-completion zsh)

# awscli
autoload bashcompinit && bashcompinit
if test -e /usr/local/bin/aws_completer; then
  complete -C '/usr/local/bin/aws_completer' aws
else
  echo "\e[1;31m[warn]\e[m aws_completer not found in /usr/local/bin/"
fi

# terraform
which terraform > /dev/null 2>&1 && complete -o nospace -C /usr/bin/terraform terraform
