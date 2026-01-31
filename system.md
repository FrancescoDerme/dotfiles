I like to work on a heavily customised system.
All the configuration files are managed through GNU stow, look at the README for further info.

Caps lock and ctrl keys have been swapped by running: gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']",
to reset to default settings run: gsettings reset org.gnome.desktop.input-sources xkb-options.
~/.bashrc has been edited so that scripts placed in ~/.local/bin/ can be called from anywhere, these include

- "enable-nextdns" and "disable-nextdns" to manage which DNS server the system queries, these require a file "~/.nextdns_id" with your NextDNS id
- "newtertab" and "closetertab" to open and close terminal tabs, these can be called through keyboard shortcuts thanks to ydotool,
  in particular alt + w opens a new tab, alt + e closes the currently-focused tab, alt + q opens a new window (this doesn't need a custom script)
- "play" to call "beets play", the input doesn't quotation marks
- "wifi" to cycle wifi settings to off and on again in order to reconnect to laggy networks

---

KEYBOARD SHORTCUTS

1.  Open new terminal: alt + q
2.  Open new terminal tab: alt + w
3.  Close terminal or terminal tab: alt + e (works when the session is empty, not inside vim)
4.  Switch to terminal tab by number: alt + (number)
5.  Switch to terinal tab by going left or right: ctrl + page up/page down (note that the "page up" button is NOT the upwards arrow key)
6.  Open browser: alt + f
7.  Enter and exit full-screen: F11
8.  Interrupt the execution of a command: ctrl + c

---

TERMIAL COMMANDS

1.  ls: see what files and directories are present in the current directory
    [-a] to see hidden files,
    [-larth] to check the files' modes,
    [-l] to see if a directory is a symbolic link
2.  echo: print
3.  mkdir: create a directory
    [-p] create intermediate directories & suppress error if the directory already exists
4.  cd: change directory
5.  clear: clear the terminal
6.  rm: remove files and directories
    [-r] to recursively remove directories,
    [-f] to remove with force
7.  pwd: present working directory. pwd | wl-copy copies the present working directory to clipboard.
8.  cat: spy a file
9.  mv: move stuff or change stuff's name
10. which: tells which version of a program is installed
11. type: tells where all the versions of program installed on the computer
12. whoami: tells which user is logged in
13. find: find files
14. chmod: changes the modes of a file
    [+x] makes the file an executable (useful when writing a bash shell script)
15. grep: find a piece of text (use it with "|" to give it the output of other commands)
16. cp: clone a file or directory
17. diff: find differences between two files
18. evince: pdf viewer.
19. flameshot gui: take screenshots.

ctrl + z pauses a running process.
bg runs a paused process in the background.
& runs a command in the background, this is useful not to have a useless terminal window open when running lasting commands.

> redirects the output.

---

COMPILING

1.  g++: compile
    [-c] to call just the compiler, not the linker and the loader, as to produce object files,
    [-I] to indicate a directory where to find the included files (can be used multiple times),
    [-O] to compile with a certain optimization level,
    [-ggdb] to compile in a debugger-friendly way, to use together with [-O0].
2.  gdb: debug
    [run] to run,
    [up] to and go back from a run-time error to the line of code wich generated it,
    [break] to insert a breakpoint,
    [print] to print a variable,
    [next] to move to the next line,
    [step] to move inside functions,
    [continue] to move to the next breakpoint.
