from diagrams import Cluster, Diagram, Edge
from diagrams.generic.network import Router, Switch
from diagrams.onprem.network import Internet
from diagrams.onprem.compute import Server
from diagrams.saas.cdn import Cloudflare
from diagrams.saas.chat import Discord
from diagrams.generic.os import Android, LinuxGeneral, Windows
from diagrams.aws.iot import IotAlexaEcho, IotLightbulb, IotSensor

with Diagram("Cluster Map", show=False):
    with Cluster("Technocore\nSidero master"):
        technocore = Server("Technocore\nRaspi4 master")

    with Cluster("Hegira\nK8s cluster"):
        leela = Server("Leela\nRaspi4\nHegira master")
        xerxes = Server("Xerxes\nNUC\nHegira worker")
        SHODAN = Server("SHODAN\nNUC\nHegira worker")
        tycho = Server("Tycho\nNUC\nHegira worker")

    leela >> [xerxes,SHODAN,tycho]
    technocore >> Edge(style="dotted") >> [leela,xerxes,SHODAN,tycho]
