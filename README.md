henteko dotfiles settings

# vim
```
$ git clone https://github.com/Shougo/neobundle.vim ~/dotfiles/neobundle.vim
$ ln -s ~/dotfiles/_vimrc ~/.vimrc
$ ln -s ~/dotfiles/vimfiles ~/.vim
# vim -> :NeoBundleInstall
$ make -f ~/.vim/vimproc/make_unix.make
```

# tmux
```
$ brew install reattach-to-user-namespace
$ ln -s ~/dotfiles/_tmux.conf ~/.tmux.conf
```

# zsh
```
$ ln -s ~/dotfiles/_zshrc ~/.zshrc
```

# gitconfig
```
$ ln -s ~/dotfiles/_gitconfig ~/.gitconfig
```
