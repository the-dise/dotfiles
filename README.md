# the_dise's dotfiles / dbox

<p align="center">
	<img src="logo.png" />
</p>

This is a repository containing the dotfiles of the user 'the_dise'. Dotfiles are configuration files for various applications and utilities.

This repository also includes a customized version of the Agnoster theme, called "dbox", which has a distinct and visually appealing appearance. The theme features a softer color scheme, with modified icons and other elements that enhance its aesthetic appeal.

## Installation

To use these dotfiles, you need to clone this repository to your home directory:

```
$ git clone https://github.com/the-dise/dotfiles.git ~/dotfiles
```

Then, you need to run the `setup.sh` script to symlink the dotfiles to their correct locations in your home directory:

```
$ cd ~/dotfiles
$ chmod +x setup.sh
$ ./setup.sh
```

This script will create symlinks in your home directory for all the dotfiles in the repository. If you already have some of these dotfiles in your home directory, the script will ask you whether to overwrite them or not.

## Customization

If you want to customize these dotfiles for your own use, you can do so by forking this repository and making changes to the files in your fork. You can also create new dotfiles for other applications or utilities by adding them to your fork.

## Credits

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [agnoster-zsh-theme](https://github.com/agnoster/agnoster-zsh-theme)
- [lightline.vim](https://github.com/itchyny/lightline.vim)
- [tpm](https://github.com/tmux-plugins/tpm)
- [tmux-autoreload](https://github.com/b0o/)
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
- [tmux-mighty-scroll](https://github.com/noscript/tmux-mighty-scroll)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)
- [tmux-sessionist](https://github.com/tmux-plugins/tmux-sessionist)
- [tmux-sidebar](https://github.com/tmux-plugins/tmux-sidebar)
- [tmux-themepack](https://github.com/jimeh/tmux-themepack)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

## License

These dotfiles are released under the MIT License. See the LICENSE file for details.
