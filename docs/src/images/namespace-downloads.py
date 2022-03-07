from diagrams import Cluster, Diagram, Edge
from diagrams.generic.network import Router, Switch
from diagrams.onprem.network import Internet
from diagrams.onprem.compute import Server
from diagrams.saas.cdn import Cloudflare
from diagrams.saas.chat import Discord
from diagrams.generic.os import Android, LinuxGeneral, Windows
from diagrams.aws.iot import IotAlexaEcho, IotLightbulb, IotSensor

with Diagram("vpn", show=False):
