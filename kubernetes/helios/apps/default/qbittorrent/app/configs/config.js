// Torrent content layout: Original
// Default Torrent Management Mode: Automatic
// Default Save Path: /media/downloads/torrents
// External program on finished: /scripts/xseed.sh "%F"

module.exports = {
  delay: 30,
  qbittorrentUrl: "http://localhost:8080",

  torznab: [
    "https://prowlarr.${EXTERNAL_DOMAIN}/18/api?apikey={{ prowlarr_api_key }}", // ipt
    "https://prowlarr.${EXTERNAL_DOMAIN}/17/api?apikey={{ prowlarr_api_key }}", // tl
    "https://prowlarr.${EXTERNAL_DOMAIN}/27/api?apikey={{ prowlarr_api_key }}", // hdt
    // "https://prowlarr.${EXTERNAL_DOMAIN}/6/api?apikey={{ prowlarr_api_key}}", // ts
    // "https://prowlarr.${EXTERNAL_DOMAIN}/7/api?apikey={{ prowlarr_api_key }}", // mtv
    // "https://prowlarr.${EXTERNAL_DOMAIN}/8/api?apikey={{ prowlarr_api_key }}", // uhd
    "https://prowlarr.${EXTERNAL_DOMAIN}/19/api?apikey={{ prowlarr_api_key }}", // fl
    "https://prowlarr.${EXTERNAL_DOMAIN}/30/api?apikey={{ prowlarr_api_key }}", // st
    "https://prowlarr.${EXTERNAL_DOMAIN}/24/api?apikey={{ prowlarr_api_key }}", // blu
    "https://prowlarr.${EXTERNAL_DOMAIN}/28/api?apikey={{ prowlarr_api_key }}", // hds
    // "https://prowlarr.${EXTERNAL_DOMAIN}/17/api?apikey={{ prowlarr_api_key }}", // ptp
    // "https://prowlarr.${EXTERNAL_DOMAIN}/42/api?apikey={{ prowlarr_api_key }}", // btn
    "https://prowlarr.${EXTERNAL_DOMAIN}/28/api?apikey={{ prowlarr_api_key }}", // hds
    "https://prowlarr.${EXTERNAL_DOMAIN}/33/api?apikey={{ prowlarr_api_key }}", // sbs
    "https://prowlarr.${EXTERNAL_DOMAIN}/34/api?apikey={{ prowlarr_api_key }}", // sbs
  ],

  action: "inject",
  includeEpisodes: true,
  includeNonVideos: true,
  duplicateCategories: true,

  matchMode: "safe",
  skipRecheck: true,
  linkType: "symlink",
  linkDir: "/media/downloads/qbittorrent/xseeds",

  // I have sonarr, radarr, and prowlarr categories set in qBittorrent
  // The save paths for them are set to the following:
  dataDirs: ["/media/downloads/qbittorrent/downloads/"],

  outputDir: "/config/xseeds",
  torrentDir: "/config/qBittorrent/BT_backup",
};
