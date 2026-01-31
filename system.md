### Settings

Caps lock and ctrl keys have been swapped by running `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"`,
to reset to default settings run `gsettings reset org.gnome.desktop.input-sources xkb-options`.

### Scripts

`~/.bashrc` is edited so that scripts placed in `~/.local/bin/` can be called from anywhere, these include:

- `enable-nextdns` and `disable-nextdns` to manage which DNS server the system queries, these require a file `~/.nextdns_id` with a NextDNS id
- `newtertab` and `closetertab` to open and close terminal tabs, these can be called through keyboard shortcuts thanks to `ydotool`,
  in particular `alt + w` opens a new tab, `alt + e` closes the currently-focused tab, `alt + q` opens a new window (this doesn't need a custom script)
- `play` as an alias to `beet play`
- `wifi` to cycle wifi settings to off and on again in order to reconnect to laggy networks

### keyboard shortcuts

- Open new terminal: `alt + q`
- Open new terminal tab: `alt + w`
- Close terminal or terminal tab: `alt + e` (works when the session is empty, not inside vim)
- Switch to terminal tab by number: `alt + number`
- Switch to terinal tab by going left or right: `ctrl + page up/down`
- Enter and exit full-screen: `F11`
- Interrupt the execution of a command: `ctrl + c`

### Bash commands

- `whoami` tell which user is logged in
- `ls` see what files and directories are present in the current directory
  - `-a` to see hidden files
  - `-l` (long format) to display, in this order, a character for the type (`-` for files and `d` for directories), nine characters for the permissions for the Owner, Group and Others (`r`, `w`, and `x` for read, writen and execute), the number of hard links to the file, the owner, the group that has access to this file, the size, the data when this file was last modified and the filename. `-h` gives the sizes in KB, MG, and GB.
  - `-t` to sort my modification time (newest first)
  - `-r` to reverse the sort
- `echo` print
- `mkdir` create a directory
  - `-p` (parents) create intermediate directories & suppress error if the directory already exists
- `cd` change directory
- `clear` clear the terminal
- `rm` remove files and directories
  - `-r` to recursively remove directories
  - `-f` to remove with force
- `pwd` present working directory
- `cat` (concatenate) display file contents or merge multiple files together
- `mv` move stuff or change stuff's name
- `which` show the path of the executable that would run. It only looks for files in `$PATH`, so it won't find shell builtins or aliases
- `type` tell what a command is (builtin function, external program, or custom shortcut) and its path. It finds shell bultins and aliases
  - `-a` to see all versions of the command
- `find` find files
- `chmod` changes the modes of a file
  - `+x` makes a file executable
- `grep` (global regular expression print) find a piece of text
- `cp` clone a file or directory
- `diff` find differences between two files
- `sed` substitution command, the syntax is `sed [options] 's/search/replace/flags' filename`
  - `-i` in place, i.e. the result is not printed but saved
  - flags: `g` (global) to replace every occurrence, `I` to ignore case
- `top` monitor what's using resoruces in real time until quitting with `q`
- `man` (manual) see what a flag does

### I/O redirection

- `|` pipe the standard output to its left to the standard input to its right
- `>` redirect the output by overwriting
- `>>` redirect the output by appending

### Job control

- `ctrl + z` suspend the current foreground process
- `bg` move a suspended process to the background
- `fg` move a background or suspended process to the foreground
- `&` run a command in the background

### External utilities

- `wl-copy` copies its input to the clipboard
- `flameshot` gui takes a screenshots
- `evince` opens a pdf

### Compiling and debugging

- `g++` compile
  - `-c` to call just the compiler, not the linker and the loader, as to produce object files
  - `-I` to indicate a directory where to find header files (can be used multiple times)
  - `-O` to compile with a certain optimization level
  - `-ggdb` to compile in a debugger-friendly way, to be used together with [-O0]
- `gdb` debug
  - `run` to run
  - `up` to move the stack frame up toward the caller
  - `break` to insert a breakpoint
  - `print` to print a variable
  - `next` to move to the next line
  - `step` to move inside a function
  - `continue` to move to the next breakpoint
