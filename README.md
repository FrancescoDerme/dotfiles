This repo uses [stow][] to manage the symlinks for my configuration files.

Basically, I have a `~/dotfiles` directory where all the config files live. When tools and shells (like `nvim` or `bash`) look for their configs and scripts in the usual places (e.g., `~/.config/nvim` or `~/.local/bin`), they find a symbolic link that points to this folder.

This makes managing configurations, sharing them across machines, and version control much easier.

### Installation

Just install `stow` (e.g., `sudo apt install stow`) and clone this repository to your home directory:

```sh
git clone https://github.com/FrancescoDerme/dotfiles.git ~/dotfiles
```

### Usage

I use a `Makefile` to simplify the stow commands. For example:

```sh
make # Installs every config
make nvim # Installs the nvim config
make delete-nvim # Deletes the nvim config
```

If you prefer running stow manually:

```sh
cd ~/dotfiles
stow --restow nvim
```

[stow]: https://www.gnu.org/software/stow/
