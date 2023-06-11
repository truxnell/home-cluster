import Config

config :pleroma, configurable_from_database: true

config :pleroma, Pleroma.Web.Endpoint,
  url: [host: "fedi.truxnell.net"]


config :pleroma, Pleroma.Web.WebFinger, domain: "truxnell.net"
