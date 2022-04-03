from diagrams import Cluster, Diagram, Edge
from diagrams.generic.network import Router, Switch
from diagrams.onprem.network import Internet
from diagrams.onprem.compute import Server
from diagrams.saas.cdn import Cloudflare
from diagrams.saas.chat import Discord
from diagrams.generic.os import Android, LinuxGeneral, Windows
from diagrams.aws.iot import IotAlexaEcho, IotLightbulb, IotSensor
from diagrams.custom import Custom

graph_attr = {
    "pad" : "0"
}

with Diagram("Network Map", show=False):

    with Cluster("Internet"):
        internet=Internet("Internet")


    with Cluster("Local"):

        with Cluster("Hardware"):
            netgear = Router("Netgear")
            net_bridge = Edge(style="dashed",label="bridge")
            udmpro = Router("UDM-PRO")
            usw = Switch("USW-24-POE")
            ap = Custom("3 x Unifi AC Lite","unifi_ac.png")
            nanobeam = Custom("2 x Nanobeam Gen2 5AC","nanobeam.png")

        with Cluster("Trusted\n10.8.10.1/24"):
            android=Android("Smartphones")
            windows=Windows("Win Laptops")
            linux=LinuxGeneral("Linux laptops")

            # android - usw

        with Cluster("Lab\n10.8.20.1/24"):

            technocore=Custom("Technocore - Sidero", "k8s.png")
            hegira=Custom("Hegira - k8s", "k8s.png")


        with Cluster("IOT / Untrusted\n10.8.30.1/24"):
            alexa=IotAlexaEcho("Alexa")
            light=IotLightbulb("IOT Lightbulb")
            sensor=IotSensor("IOT Sensors")



    internet - netgear - net_bridge - udmpro >> usw >> ap
    usw >> nanobeam
    usw >> technocore
    usw >> hegira
    ap >> light
    ap >> sensor
    ap >> android
    ap >> windows
    ap >> alexa
    ap >> linux
