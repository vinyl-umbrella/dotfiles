autoload -Uz compinit && compinit -C

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' group-name ''

# exclude macOS
if [[ $OSTYPE == Linux* ]]; then
  zstyle ':completion:*' special-dirs true
  zstyle ':completion:*' list-colors `dircolors`
fi

autoload bashcompinit && bashcompinit

setopt auto_param_keys
setopt correct

# awscli
if test -e /usr/local/bin/aws_completer; then
  complete -C '/usr/local/bin/aws_completer' aws
else
  echo "\e[1;31m[warn]\e[m aws_completer not found in /usr/local/bin/"
fi

