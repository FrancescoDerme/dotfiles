## Francesco's Dotfiles

This repo uses [stow][] to manage the symlinks for my configuration files.

Basically, I have a `~/dotfiles` directory where all the actual config files live. When tools and shells (like `nvim` or `bash`) look for their configs and scripts in the usual places (e.g., `~/.config/nvim` or `~/.local/bin`), they find a symbolic link that points back to this folder.

This makes managing configurations, sharing them across machines, and version control much easier.

### Installation

1. Install `stow` (e.g., `sudo apt install stow`)
2. Clone this repository to your home directory:
   ```sh
   git clone https://github.com/FrancescoDerme/dotfiles.git ~/dotfiles
   ```

### Usage

I use a `Makefile` to simplify the stow commands. For example:

```sh
make # Installs everything
make nvim # Installs nvim
make delete-nvim # Deletes nvim
```

If you prefer running stow manually:

```sh
cd ~/dotfiles
stow --restow nvim
```

[stow]: https://www.gnu.org/software/stow/
