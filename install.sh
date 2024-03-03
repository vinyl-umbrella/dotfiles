# !/usr/bin/env zsh
set -ue

script_dir="$(cd "$(dirname $0)" && pwd -P)"


link_to_homedir() {
    command echo "link to \e[1;35m$HOME/.config\e[m"

    # loop for each files in ./config
    for f in $script_dir/config/*; do
        # backup if exists config and not link
        if test -e "$HOME/.config/$(basename $f)" && ! test -L "$HOME/.config/$(basename $f)"; then
            command mv "$HOME/.config/$(basename $f)" "$script_dir/backup"
        fi

        # link
        command ln -snf $f $HOME/.config
    done

    # link for .emacs
    command echo "link to \e[1;35m$HOME/.emacs\e[m"
    if test -e "$HOME/.emacs" && ! test -L "$HOME/.emacs"; then
        command mv "$HOME/.emacs" "$script_dir/backup"
    fi
    command ln -snf $script_dir/emacs $HOME/.emacs


    # link for .zshrc
    command echo "link to \e[1;35m$HOME/.zshrc\e[m"
    if test -e "$HOME/.zshrc" && ! test -L "$HOME/.zshrc"; then
        command mv "$HOME/.zshrc" "$script_dir/backup"
    fi
    if test -e "$HOME/.zsh" && ! test -L "$HOME/.zsh"; then
        command mv "$HOME/.zsh" "$script_dir/backup"
    fi

    command ln -snf $script_dir/zshrc $HOME/.zshrc
    command ln -snf $script_dir/zsh $HOME/.zsh

    # link for .gitconfig
    command echo "link to \e[1;35m$HOME/.gitconfig\e[m"
    if test -e "$HOME/.gitconfig" && ! test -L "$HOME/.gitconfig"; then
        command mv "$HOME/.gitconfig" "$script_dir/backup"
    fi
    command ln -snf $script_dir/gitconfig $HOME/.gitconfig
}


link_to_homedir
echo "\e[1;36mInstall completed!!!! \e[m"
