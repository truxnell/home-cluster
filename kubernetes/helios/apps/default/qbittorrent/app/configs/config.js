// Torrent content layout: Original
// Default Torrent Management Mode: Automatic
// Default Save Path: /media/downloads/torrents
// External program on finished: /scripts/xseed.sh "%F"

module.exports = {
  delay: 30,
  qbittorrentUrl: "http://localhost:8080",

  torznab: [
    "http://prowlarr.media.svc.cluster.local:9696/3/api?apikey={{ .PROWLAR__API_KEY }}", // ipt
    "http://prowlarr.media.svc.cluster.local:9696/4/api?apikey={{ .PROWLAR__API_KEY }}", // tl
    "http://prowlarr.media.svc.cluster.local:9696/5/api?apikey={{ .PROWLAR__API_KEY }}", // hdt
    "http://prowlarr.media.svc.cluster.local:9696/6/api?apikey={{ .PROWLAR__API_KEY }}", // ts
    "http://prowlarr.media.svc.cluster.local:9696/7/api?apikey={{ .PROWLAR__API_KEY }}", // mtv
    "http://prowlarr.media.svc.cluster.local:9696/8/api?apikey={{ .PROWLAR__API_KEY }}", // uhd
    "http://prowlarr.media.svc.cluster.local:9696/11/api?apikey={{ .PROWLAR__API_KEY }}", // fl
    "http://prowlarr.media.svc.cluster.local:9696/15/api?apikey={{ .PROWLAR__API_KEY }}", // st
    "http://prowlarr.media.svc.cluster.local:9696/16/api?apikey={{ .PROWLAR__API_KEY }}", // blu
    "http://prowlarr.media.svc.cluster.local:9696/17/api?apikey={{ .PROWLAR__API_KEY }}", // ptp
    "http://prowlarr.media.svc.cluster.local:9696/42/api?apikey={{ .PROWLAR__API_KEY }}", // btn
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
