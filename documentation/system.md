### Settings

- Caps lock and ctrl keys have been swapped by running `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"`, to reset to default settings run `gsettings reset org.gnome.desktop.input-sources xkb-options`
- Visual bell has been disabled by running `echo "set bell-style none" >> ~/.inputrc`
- Screen blank timer has been set to 1 hour by running `gsettings set org.gnome.desktop.session idle-delay 3600`
- System sleep timer and notifications have been disabled by running `gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'`, `gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'`, `gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0`, and `gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0`

### keyboard shortcuts

- Open new terminal: `alt + q`
- Open new terminal tab: `alt + w`
- Close terminal or terminal tab: `alt + e` (works when the session is empty, not inside vim)
- Switch to terminal tab by number: `alt + number`
- Switch to terinal tab by going left or right: `ctrl + page up/down`
- Enter and exit full-screen: `F11`
- Interrupt the execution of a command: `ctrl + c`
