# load from splitted zsh config files
ZSHHOME="${HOME}/.zsh"

if [[ -d $ZSHHOME && -r $ZSHHOME && -x $ZSHHOME ]]; then
  for i in $ZSHHOME/*.zsh; do
    [[ -f $i || -h $i ]] && [[ -r $i ]] && source "$i"
  done
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
