## Francesco's Dotfiles

This repo uses [stow][] to manage the symlinks to the files that hold the user settings of the programs I use.
Basically I have a `~/dotfiles` directory where all the configuration files are stored, when programs like neovim go look for them in the usual directory they instead find a symbolic link which points to the folder where they're actually stored. This makes managing configuration files, sharing them across multiple machines and using a version control tool to back them up much more convenient, but keeping track of the symlinks becomes a mess; stow does this for us.

I haven't tested this, but I think that to replicate my setup it should be enough to install stow, clone this repository into `~/dotfiles` and do:

```sh
cd ~/dotfiles
stow --restow nvim # just neovim
# stow --restow */ # every package
```

stow will automatically create a symlink from the contents of each "package" to the directory from where it is invoked, i.e. your ~/dotfiles` directory.

[stow]: https://www.gnu.org/software/stow/
