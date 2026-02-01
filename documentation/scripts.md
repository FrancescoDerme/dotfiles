### Scripts

- `enable-nextdns` and `disable-nextdns` to manage which DNS server the system queries, these require a file `~/dotfiles/private/nextdns_id` with a NextDNS id
- `newtertab` and `closetertab` to open and close terminal tabs, these can be called through keyboard shortcuts thanks to `ydotool`,
  in particular `alt + w` opens a new tab, `alt + e` closes the currently-focused tab, `alt + q` opens a new window (this doesn't need a custom script)
- `wifi` to cycle wifi settings to off and on again in order to reconnect to laggy networks
- `bd` to toggle the bluetooth connection to a specific bluetooth device, this requires a file `~/dotfiles/private/bluetooth_device` with the device's MAC address
