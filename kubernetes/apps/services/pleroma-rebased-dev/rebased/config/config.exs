import Config

config :pleroma, configurable_from_database: true

config :pleroma, Pleroma.Web.Endpoint,
  url: [host: "fedi.voltaicforge.com"]


config :pleroma, Pleroma.Web.WebFinger, domain: "voltaicforge.com"
