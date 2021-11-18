"""Validates that all files in the repo are valid kustomizations."""

import pytest
import git
import os
import subprocess
import logging
import yaml

_LOGGER = logging.getLogger(__name__)

KUSTOMIZE_BIN = "kustomize"
KUSTOMIZE_CONFIG = "kustomization.yaml"
KUSTOMIZE_FLAGS = []

KUSTOMIZATION_KIND = "Kustomization"
KUSTOMIZATION_API_VERSIONS = ["kustomize.toolkit.fluxcd.io/v1beta1"]

EXCLUDE_FILES = {}


def run_command(command):
    """Run the specified command and return stdout."""
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (out, err) = proc.communicate()
    if proc.returncode:
        _LOGGER.error(
            "Subprocess failed %s with return code %s", command, proc.returncode
        )
        _LOGGER.info(out.decode("utf-8"))
        _LOGGER.error(err.decode("utf-8"))
        return None
    return out.decode("utf-8")


def kustomize_grep(cluster_path, kind):
    """Loads all Kustomizations for a specific kind as a yaml object."""
    command = [KUSTOMIZE_BIN, "cfg", "grep", f"kind={kind}", cluster_path]
    doc_contents = run_command(command)
    for doc in yaml.safe_load_all(doc_contents):
        yield doc


def kind_filter(kind, api_versions):
    """Return a yaml doc filter for specified resource type and version."""

    def func(doc):
        if doc.get("kind") != kind:
            return False
        return doc.get("apiVersion") in api_versions

    return func


def kustomize_build(filename):
    command = ["kustomize", "build", filename]
    command.extend(KUSTOMIZE_FLAGS)
    return run_command(command)


def repo_root():
    git_repo = git.Repo(os.getcwd(), search_parent_directories=True)
    return git_repo.git.rev_parse("--show-toplevel")


def kustomization_files():
    root = repo_root()
    matches = []
    is_kustomization = kind_filter(KUSTOMIZATION_KIND, KUSTOMIZATION_API_VERSIONS)
    yaml_docs = kustomize_grep(root, "Kustomization")
    for doc in filter(is_kustomization, yaml_docs):
        if doc["metadata"]["name"] == "flux-system":
            continue
        if doc["spec"]["sourceRef"]["kind"] != "GitRepository":
            continue
        if "path" not in doc["spec"]:
            raise Exception(f"Invalid spec/path in doc {doc}")
        path = doc["spec"]["path"]
        matches.append(doc["spec"]["path"])
    return matches


def test_kustomize_version():
    command = ["kustomize", "version"]
    _LOGGER.info(run_command(command))


@pytest.mark.parametrize("filename", kustomization_files())
def test_validate_kustomization_file(filename):
    if filename in EXCLUDE_FILES:
        pytest.skip("File excluded from tests")
        return

    root = repo_root()
    full_path = f"{root}/{filename}"
    assert kustomize_build(full_path)
