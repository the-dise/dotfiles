# the_dise's dotfiles

Welcome to the_dise's Dotfiles repository! This collection includes configuration files (dotfiles) for various applications and utilities.

## Contents

- **Zsh**: Custom configuration for Zsh, including the `starship.rs` prompt.
- **Tmux**: Configuration for Tmux for enhanced terminal multiplexing.
- **MPV**: Custom settings for the MPV media player.
- **Neovim**: Configuration for Neovim, tailored with `nvchad`.
- **Additional Configs**:
  - `fastfetch`: Configuration for the `fastfetch` tool.
  - `logid`: Configuration for Logitech devices using `logid`.

## Setup

To set up these dotfiles on your system, follow the steps below:

### Prerequisites

Ensure you have the following tools installed:
- `curl`
- `zsh`
- `tmux`
- `mpv`
- `neovim`
- `logid` (for Logitech devices)
- `fastfetch` (if you want to use fastfetch)

### Installation

1. **Clone the Repository**

   ```sh
   git clone https://github.com/the-dise/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Run the Setup Script**

   Execute the `setup.sh` script to create the necessary symbolic links and install `starship.rs`:

   ```sh
   chmod +x setup.sh
   ./setup.sh
   ```

   This script will:

   - Configure Zsh and install `starship.rs` if not already installed.
   - Set up Tmux configuration.
   - Configure MPV.
   - Set up Neovim.
   - Optionally set up additional configurations for `fastfetch` and `logid`.

## Credits

This repository utilizes configurations and tools from various open-source projects:

- [Starship](https://starship.rs/): The minimal, blazing-fast, and infinitely customizable prompt for any shell.
- [NvChad](https://nvchad.com/): A Neovim config written in Lua to provide a feature-rich development environment.
- [PixlOne/logiops](https://github.com/PixlOne/logiops): An unofficial driver for Logitech's HID++ devices.
- [fastfetch](https://github.com/LinusDierheimer/fastfetch): A neofetch-like tool for fetching system information.