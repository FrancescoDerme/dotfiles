## Architecture

1.  Beets: imports, tags, and organizes files in `~/Music`
2.  MPD: headless audio engine playing local files via Pipewire
3.  Ncmpcpp: terminal interface for controlling MPD locally
4.  Navidrome: dockerized streaming server for mobile access
5.  Tailscale: VPN mesh allowing remote access to Navidrome

## Use

### Import music

`beet import path/to/file/or/folder`, since `beets` tends to be quite picky with tags and metadata, it might be useful to give it the release id from the [MusicBrainz][] database when importing, this is found in the last part of the url of a release's webpage.

### Play music

On pc, `play something` plays something via `mpv`, `something` is fuzzily-matched by `beets` to something in the library and can be a song, an album, an artist, a genre, etc. Alternativaly `ncmpcpp` opens a GUI to interact with `mpd`. On mobile, when the `Navidrome` and `Tailscale` services are running, content can be streamed from the pc to apposite apps.

### Create a playlist

Create playlists via `ncmpcpp` and save them, these are found in `~/Music/Playlists`. If a playlist created in `ncmpcpp` shows 0 songs on mobile, run this (once per playlist) to make the paths relative:

```bash
cd ~/Music/Playlists
sed -i 's|^|../|' NameOfPlaylist.m3u
```

## Manual

### Beets

- Config file directory: `beet config -p`
- Import music: `beet import`
- Play music: `beet play` or just `play` thanks to a script
  Since `Beets` is using `mpv` to play, `mpv` hotkeys are available while playing:
  - Pause/unpause: spacebar,
  - Skip 5 seconds forward/backward: right/left arrow,
  - Skip 1 minute forward/backward: up/down arrow,
  - Xext/previous track: >/<,
  - Quit: `q`

### MPD

- Status: `systemctl --user status mpd`
- Restart (and apply changes to `mpd.conf`): `systemctl --user restart mpd`
- Logs: `tail -f ~/.mpd/mpd.log`
- Force DB update: inside ncmpcpp, press `u`

### Navidrome

- Status: `docker ps`
- Start (and apply changes to `docker-compose.yml`): `docker compose -f ~/navidrome/docker-compose.yml up -d`
- Stop: `docker compose -f ~/navidrome/docker-compose.yml down`
- Restart: `docker restart navidrome`
- Logs: `docker logs -f navidrome`
- Update version:
  ```bash
  cd ~/navidrome
  docker compose pull
  docker compose up -d
  ```

[MusicBrainz]: https://musicbrainz.org/
