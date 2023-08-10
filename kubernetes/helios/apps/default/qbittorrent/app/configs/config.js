// Torrent content layout: Original
// Default Torrent Management Mode: Automatic
// Default Save Path: /media/downloads/torrents
// External program on finished: /scripts/xseed.sh "%F"

module.exports = {
  delay: 30,
  qbittorrentUrl: "http://localhost:8080",

  torznab: [
    "http://prowlarr.trux.dev/18/api?apikey={{ .PROWLARR__API_KEY }}", // ipt
    "http://prowlarr.trux.dev/17/api?apikey={{ .PROWLARR__API_KEY }}", // tl
    // "http://prowlarr.trux.dev/5/api?apikey={{ .PROWLARR__API_KEY }}", // hdt
    // "http://prowlarr.trux.dev/6/api?apikey={{ .PROWLARR__API_KEY }}", // ts
    // "http://prowlarr.trux.dev/7/api?apikey={{ .PROWLARR__API_KEY }}", // mtv
    // "http://prowlarr.trux.dev/8/api?apikey={{ .PROWLARR__API_KEY }}", // uhd
    "http://prowlarr.trux.dev/19/api?apikey={{ .PROWLARR__API_KEY }}", // fl
    // "http://prowlarr.trux.dev/15/api?apikey={{ .PROWLARR__API_KEY }}", // st
    // "http://prowlarr.trux.dev/16/api?apikey={{ .PROWLARR__API_KEY }}", // blu
    // "http://prowlarr.trux.dev/17/api?apikey={{ .PROWLARR__API_KEY }}", // ptp
    // "http://prowlarr.trux.dev/42/api?apikey={{ .PROWLARR__API_KEY }}", // btn
  ],

  action: "inject",
  includeEpisodes: true,
  includeNonVideos: true,
  duplicateCategories: true,

  matchMode: "safe",
  skipRecheck: true,
  linkType: "symlink",
  linkDir: "/media/downloads/torrents/xseeds",

  // I have sonarr, radarr, and prowlarr categories set in qBittorrent
  // The save paths for them are set to the following:
  dataDirs: [
    "/media/downloads/torrents/sonarr",
    "/media/downloads/torrents/radarr",
    "/media/downloads/torrents/prowlarr",
  ],

  outputDir: "/config/xseeds",
  torrentDir: "/config/qBittorrent/BT_backup",
};
