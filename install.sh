#!/bin/bash

if [ ! -d "$HOME"/.config/nvim/plugged ]; then
	mkdir -p "$HOME"/.config/nvim/plugged
fi

curl -fLo "$HOME"/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo apt install peco zsh

ln -sf "$HOME"/.dotfiles/vimrc "$HOME"/.config/nvim/init.vim
ln -sf "$HOME"/.dotfiles/bashrc "$HOME"/.bashrc
ln -sf "$HOME"/.dotfiles/zshrc "$HOME"/.zshrc
ln -sf "$HOME"/.dotfiles/tmux.conf "$HOME"/.tmux.conf
ln -sf "$HOME"/.dotfiles/ansible.cfg "$HOME"/.ansible.cfg


command -v deno
is_deno_installed=$?
if [[ $is_deno_installed == 1 ]]; then
	echo deno installing...
	curl -fsSL https://deno.land/x/install/install.sh | sh
	echo deno install complete
fi
