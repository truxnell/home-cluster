import argparse
import logging
import os
import sys
from os.path import abspath

from jinja2 import Environment, FileSystemLoader
from ruamel.yaml import YAML

TEMPLATE_DIR = "./templates/"
DRY_RUN = False
OVERWRITE = True
VOLSYNC = True
KUSTOMIZE_APP = True


class CustomFormatter(logging.Formatter):
    """Logging colored formatter, adapted from https://stackoverflow.com/a/56944256/3638629"""

    grey = "\x1b[38;21m"
    blue = "\x1b[38;5;39m"
    yellow = "\x1b[38;5;226m"
    red = "\x1b[38;5;196m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"

    def __init__(self, fmt):
        super().__init__()
        self.fmt = fmt
        self.formats = {
            logging.DEBUG: self.grey + self.fmt + self.reset,
            logging.INFO: self.blue + self.fmt + self.reset,
            logging.WARNING: self.yellow + self.fmt + self.reset,
            logging.ERROR: self.red + self.fmt + self.reset,
            logging.CRITICAL: self.bold_red + self.fmt + self.reset,
        }

    def format(self, record):
        log_fmt = self.formats.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


def setup_logging(level: str):

    log = logging.getLogger(__name__)
    log.propagate = False

    fmt = "%(asctime)s | %(levelname)8s | %(message)s"

    stdout_handler = logging.StreamHandler()
    stdout_handler.setLevel(logging.DEBUG)
    stdout_handler.setFormatter(CustomFormatter(fmt))

    file_handler = logging.FileHandler(f"{sys.argv[0]}.log")
    file_handler.setLevel(logging.DEBUG)

    # logging.basicConfig(level=level)

    log.addHandler(stdout_handler)
    log.addHandler(file_handler)
    log.debug("Logging setup")

    levels: dict = {
        "critical": logging.CRITICAL,
        "error": logging.ERROR,
        "warn": logging.WARNING,
        "warning": logging.WARNING,
        "info": logging.INFO,
        "debug": logging.DEBUG,
    }

    if level is None:
        raise ValueError(
            f"log level given: {level}"
            f" -- must be one of: {' | '.join(levels.keys())}"
        )

    log.setLevel(logging.DEBUG)

    return log


if __name__ == "__main__":

    log = setup_logging("debug")
    log.debug("Load template environment")

    # init runaemal.yaml thingy
    yaml = YAML(typ="rt")
    yaml.indent(mapping=2, sequence=4, offset=2)
    yaml.explicit_start = True

    env = Environment(
        loader=FileSystemLoader(TEMPLATE_DIR), trim_blocks=True, lstrip_blocks=True
    )

    root_dir = "/home/nat/git/Truxnell/home-cluster3/kubernetes/apps"

    log.debug("Get volsync template")
    volsync_tmpl = env.get_template("volsync_tmpl.j2")

    log.debug("Get volsync template")
    kustomization_tmpl = env.get_template("kustomization_tmpl.j2")

    for dirpath, dirnames, filenames in os.walk(root_dir):
        level = len(abspath(dirpath).split(os.path.sep)) - len(
            abspath(root_dir).split(os.path.sep)
        )

        if level == 3:
            pathsplit = dirpath.split(os.path.sep)
            namespace = pathsplit[-3]
            app = pathsplit[-2]
            subapp = pathsplit[-1]
            values = {"name": app, "namespace": namespace, "subapp": subapp}
            # Volsync
            if VOLSYNC:
                log.debug(f"Found level 3 app path {dirpath}")
                if "pvc.yaml" in filenames:
                    file = os.path.join(dirpath, "volsync.yaml")
                    if os.path.exists(file):
                        if OVERWRITE:
                            log.debug(
                                f"Overwriting Volsync file already exists in {dirpath}"
                            )
                            if not DRY_RUN:
                                with open(file, "w+") as f:
                                    f.write(volsync_tmpl.render(values))
                        else:
                            log.debug(
                                f"Skipping over Volsync file already exists in {dirpath}"
                            )
                    else:
                        log.debug(f"Creating volsync file in {dirpath}")
                        if not DRY_RUN:
                            with open(file, "w+") as f:
                                f.write(volsync_tmpl.render(values))

            # Kustomization
            file = os.path.join(dirpath, "kustomization.yaml")

            if os.path.exists(file):
                if OVERWRITE:
                    if not DRY_RUN:
                        log.debug(
                            f"Loading Kustomization file to ensure resources align to files {dirpath}"
                        )
                        with open(file, "r") as f:
                            file_yaml = yaml.load(f.read())

                        resources = filenames.copy()
                        resources.remove("kustomization.yaml")
                        resources = [
                            f"./{item}" for item in resources if item[-5:] == ".yaml"
                        ]

                        file_yaml["resources"] = resources

                        log.debug(
                            f"Overwriting Kustomization file already exists in {dirpath}"
                        )
                        with open(file, "w") as f:
                            yaml.dump(file_yaml, f)
                else:
                    log.debug(
                        f"Skipping over Kustomization file already exists in {dirpath}"
                    )
            else:
                if not DRY_RUN:
                    log.debug(f"Creating Kustomization file in {dirpath}")
                    with open(file, "w+") as f:
                        f.write(kustomization_tmpl.render(values))
