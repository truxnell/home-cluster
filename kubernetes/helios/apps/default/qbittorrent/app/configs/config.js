// Torrent content layout: Original
// Default Torrent Management Mode: Automatic
// Default Save Path: /media/downloads/torrents
// External program on finished: /scripts/xseed.sh "%F"

module.exports = {
  delay: 30,
  qbittorrentUrl: "http://localhost:8080",

  torznab: [
    "https://prowlarr.trux.dev/18/api?apikey={{ .PROWLARR__API_KEY }}", // ipt
    "https://prowlarr.trux.dev/17/api?apikey={{ .PROWLARR__API_KEY }}", // tl
    "https://prowlarr.trux.dev/27/api?apikey={{ .PROWLARR__API_KEY }}", // hdt
    // "https://prowlarr.trux.dev/6/api?apikey={{ .PROWLARR__API_KEY }}", // ts
    // "https://prowlarr.trux.dev/7/api?apikey={{ .PROWLARR__API_KEY }}", // mtv
    "https://prowlarr.trux.dev/40/api?apikey={{ .PROWLARR__API_KEY }}", // uhd
    "https://prowlarr.trux.dev/19/api?apikey={{ .PROWLARR__API_KEY }}", // fl
    "https://prowlarr.trux.dev/30/api?apikey={{ .PROWLARR__API_KEY }}", // st
    "https://prowlarr.trux.dev/24/api?apikey={{ .PROWLARR__API_KEY }}", // blu
    "https://prowlarr.trux.dev/28/api?apikey={{ .PROWLARR__API_KEY }}", // hds
    // "https://prowlarr.trux.dev/17/api?apikey={{ .PROWLARR__API_KEY }}", // ptp
    // "https://prowlarr.trux.dev/42/api?apikey={{ .PROWLARR__API_KEY }}", // btn
    "https://prowlarr.trux.dev/28/api?apikey={{ .PROWLARR__API_KEY }}", // hds
    "https://prowlarr.trux.dev/33/api?apikey={{ .PROWLARR__API_KEY }}", // sbs
    "https://prowlarr.trux.dev/34/api?apikey={{ .PROWLARR__API_KEY }}", // phd
    "https://prowlarr.trux.dev/39/api?apikey={{ .PROWLARR__API_KEY }}", // ath
    "https://prowlarr.trux.dev/41/api?apikey={{ .PROWLARR__API_KEY }}", // rtt
    "https://prowlarr.trux.dev/42/api?apikey={{ .PROWLARR__API_KEY }}", // stc
    "https://prowlarr.trux.dev/44/api?apikey={{ .PROWLARR__API_KEY }}", // stt
    "https://prowlarr.trux.dev/43/api?apikey={{ .PROWLARR__API_KEY }}", // ath
  ],

  action: "inject",
  includeEpisodes: true,
  includeNonVideos: true,
  duplicateCategories: true,

  matchMode: "safe",
  skipRecheck: true,
  linkType: "symlink",
  linkDir: "/media/downloads/qbittorrent/complete/xseeds",

  // I have sonarr, radarr, and prowlarr categories set in qBittorrent
  // The save paths for them are set to the following:
  dataDirs: [
    "/media/downloads/qbittorrent/complete/prowlarr/",
    "/media/downloads/qbittorrent/complete/radarr/",
    "/media/downloads/qbittorrent/complete/sonarr/",
  ],

  outputDir: "/config/xseeds",
  torrentDir: "/config/qBittorrent/BT_backup",
};
