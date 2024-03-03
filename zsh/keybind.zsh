bindkey -e                                  # emacs key bindings
bindkey ' ' magic-space                     # do history expansion on space
if [[ $OSTYPE == darwin* ]]; then
  bindkey "[D" backward-word
  bindkey "[C" forward-word
else
  bindkey ";3D" backward-word
  bindkey ";3C" forward-word
fi

bindkey '^[Z' undo
