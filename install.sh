# !/usr/bin/env zsh
set -ue

DOTFILES_DIR="$(cd "$(dirname $0)" && pwd -P)"

# zsh
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/zlogout ~/.zlogout
ln -sf $DOTFILES_DIR/zsh/ ~/.zsh

# emcas
ln -sf $DOTFILES_DIR/emacs ~/.emacs

# config
ln -sf $DOTFILES_DIR/config/bat ~/.config/bat
ln -sf $DOTFILES_DIR/config/Code ~/.config/Code
ln -sf $DOTFILES_DIR/config/git ~/.config/git
ln -sf $DOTFILES_DIR/config/htop ~/.config/htop
ln -sf $DOTFILES_DIR/config/neofetch ~/.config/neofetch
