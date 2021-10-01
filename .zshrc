# プロンプト
PROMPT="%F{cyan}[%(5~,%-1~/.../%2~,%~)]%f$ "
RPROMPT="%F{white} %D{%H:%M:%S}%f"

autoload -Uz colors; colors

# 補完
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# 聞き直す
setopt correct
# 重複追加しない
setopt HIST_IGNORE_DUPS
# かっこ自動補完
setopt auto_param_keys

setopt extended_history

# エイリアス
alias ls='ls --color -F'
alias sl='ls'
alias la='ls -A'
alias ll='ls -gh'
alias lla='ll -A'
alias em='emacs'
alias history='history -t "%F %T"'
alias grep='grep --color=auto'
alias pip3='python3 -m pip'

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups

export PATH=$HOME/.local/bin:$PATH

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions


# /usr/bin/neofetch 