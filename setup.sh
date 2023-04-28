
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

sudo apt install zsh curl git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

relink ~/dotfiles/zsh/zshrc ~/.zshrc
relink ~/dotfiles/zsh/dbox.zsh-theme ~/.oh-my-zsh/custom/themes/dbox.zsh-theme

# ./setup_git
# ./setup_vim
# ./setup_tmux
