## Architecture

1.  Beets: imports, tags, and organizes files in `~/Music`
2.  MPD: headless audio engine playing local files via Pipewire
3.  Ncmpcpp: terminal interface for controlling MPD locally
4.  Navidrome: dockerized streaming server for mobile access
5.  Tailscale: VPN mesh allowing remote access to Navidrome

## Use

### Ncmpcpp

- If a playlist created in ncmpcpp shows 0 songs on mobile (Navidrome), run this (once per playlist) to make the paths relative:
  ```bash
  cd ~/Music/Playlists
  sed -i 's|^|../|' NameOfPlaylist.m3u
  ```

## Maintenance

### MPD

- Status: `systemctl --user status mpd`
- Restart (and apply changes to `mpd.conf`): `systemctl --user restart mpd`
- Logs: `tail -f ~/.mpd/mpd.log`
- Force DB update: inside ncmpcpp, press `u`

### Navidrome

- Check status: `docker ps`
- Start (and apply changes to `docker-compose.yml`): `docker compose -f ~/navidrome/docker-compose.yml up -d`
- Stop: `docker compose -f ~/navidrome/docker-compose.yml down`
- Restart: `docker restart navidrome`
- View logs: `docker logs -f navidrome`
- Update version:
  ```bash
  cd ~/navidrome
  docker compose pull
  docker compose up -d
  ```
