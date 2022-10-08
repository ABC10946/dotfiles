curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf $HOME/.dotfiles/vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles/bashrc $HOME/.bashrc
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
