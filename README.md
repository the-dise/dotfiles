# the_dise's dotfiles

<p align="center">
    <img src="logo.png" alt="dbox Logo"/>
</p>

Welcome to the_dise's Dotfiles repository! This collection includes configuration files (dotfiles) for various applications and utilities, as well as a customized version of the Agnoster theme known as "dbox." The dbox theme offers a visually distinct appearance with a softer color scheme and modified icons, enhancing both functionality and aesthetics.

## Installation

To integrate these dotfiles into your system, follow these steps:

1. **Install oh-my-zsh**: If not already installed, run the following command to install [oh-my-zsh](https://ohmyz.sh/#install):
   ```shell
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Clone this repository**: Clone the dotfiles repository to your home directory:
   ```shell
      git clone https://github.com/the-dise/dotfiles.git ~/.dotfiles
   ```

3. **Initialize submodules**: Move into the dotfiles directory and update submodules:
   ```shell
      cd ~/.dotfiles
   ```

4. **Run setup script**: Make the setup script executable and execute it:
   ```shell
      chmod +x setup.sh
      ./setup.sh
   ```

5. **Install Vim plugins**: Launch Vim and run the following command to install plugins:
   - Enter command mode by pressing `:` and write `PlugInstall`

6. **Install tmux plugins**: Launch tmux and press `prefix` + `I` to install plugins.

7. **Install logiopt config**: 
   ```shell
      sudo ln -s ~/.dotfiles/configs/logid.cfg /etc/logid.cfg
   ``` 

The setup script will create symbolic links in your home directory for all the dotfiles in the repository. If any conflicting dotfiles exist, the script will prompt you to decide whether to overwrite them or not.

## Customization

Feel free to customize these dotfiles to suit your preferences. Fork this repository to your own GitHub account and modify the files as needed. You can also add new dotfiles for other applications or utilities according to your requirements.

## Credits

This project stands on the shoulders of giants. We extend our gratitude to the following projects and their contributors:

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
- [NormalNvim](https://github.com/NormalNvim/NormalNvim)

## License

These dotfiles are distributed under the MIT License. See the [LICENSE](LICENSE) file for details.
