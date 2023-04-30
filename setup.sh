
#!/bin/bash

relink () {
  src="$1"
  dst="$2"

  rm -rf "$dst"

  dir=$(dirname "$dst")
  [[ ! -d "$dir" ]] && mkdir -p "$dir"

  ln -s "$src" "$dst"
}

XDG_CONFIG_HOME=$XDG_CONFIG_HOME:=$HOME/.config

relink ~/dotfiles/zsh/zshrc ~/.zshrc
relink ~/dotfiles/zsh/dbox.zsh-theme ~/.oh-my-zsh/custom/themes/dbox.zsh-theme
relink ~/dotfiles/vim ~/.vim
relink ~/dotfiles/vim/vimrc ~/.vimrc

./setup_omzsh.sh
# ./setup_vim
# ./setup_tmux
