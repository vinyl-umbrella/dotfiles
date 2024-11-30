# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz colors
eval "$(ssh-agent -s)" > /dev/null 2>&1

# load from splitted zsh config files
ZSHHOME="${HOME}/.zsh"

if [[ -d $ZSHHOME && -r $ZSHHOME && -x $ZSHHOME ]]; then
  for i in $ZSHHOME/*.zsh; do
    [[ -f $i || -h $i ]] && [[ -r $i ]] && source "$i"
  done
fi

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
