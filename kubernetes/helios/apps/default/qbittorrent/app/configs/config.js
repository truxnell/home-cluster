// Torrent content layout: Original
// Default Torrent Management Mode: Automatic
// Default Save Path: /media/downloads/torrents
// External program on finished: /scripts/xseed.sh "%F"

module.exports = {
  delay: 30,
  qbittorrentUrl: "http://localhost:8080",

  torznab: [
    "https://prowlarr.${EXTERNAL_DOMAIN}/18/api?apikey=${PROWLARR__API_KEY}", // ipt
    "https://prowlarr.${EXTERNAL_DOMAIN}/17/api?apikey=${PROWLARR__API_KEY}", // tl
    "https://prowlarr.${EXTERNAL_DOMAIN}/27/api?apikey=${PROWLARR__API_KEY}", // hdt
    // "https://prowlarr.${EXTERNAL_DOMAIN}/6/api?apikey={{ prowlarr_api_key}}", // ts
    // "https://prowlarr.${EXTERNAL_DOMAIN}/7/api?apikey=${PROWLARR__API_KEY}", // mtv
    "https://prowlarr.${EXTERNAL_DOMAIN}/40/api?apikey=${PROWLARR__API_KEY}", // uhd
    "https://prowlarr.${EXTERNAL_DOMAIN}/19/api?apikey=${PROWLARR__API_KEY}", // fl
    "https://prowlarr.${EXTERNAL_DOMAIN}/30/api?apikey=${PROWLARR__API_KEY}", // st
    "https://prowlarr.${EXTERNAL_DOMAIN}/24/api?apikey=${PROWLARR__API_KEY}", // blu
    "https://prowlarr.${EXTERNAL_DOMAIN}/28/api?apikey=${PROWLARR__API_KEY}", // hds
    // "https://prowlarr.${EXTERNAL_DOMAIN}/17/api?apikey=${PROWLARR__API_KEY}", // ptp
    // "https://prowlarr.${EXTERNAL_DOMAIN}/42/api?apikey=${PROWLARR__API_KEY}", // btn
    "https://prowlarr.${EXTERNAL_DOMAIN}/28/api?apikey=${PROWLARR__API_KEY}", // hds
    "https://prowlarr.${EXTERNAL_DOMAIN}/33/api?apikey=${PROWLARR__API_KEY}", // sbs
    "https://prowlarr.${EXTERNAL_DOMAIN}/34/api?apikey=${PROWLARR__API_KEY}", // phd
    "https://prowlarr.${EXTERNAL_DOMAIN}/39/api?apikey=${PROWLARR__API_KEY}", // ath
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
