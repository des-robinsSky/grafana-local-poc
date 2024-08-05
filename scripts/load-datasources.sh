#!/usr/bin/env bash

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

exit_with_error() {
    log "ERROR: $1"
    exit 1
}

PROJECT_DIR="$(git rev-parse --show-toplevel)"
if [ $? -ne 0 ]; then
    exit_with_error "Not inside a Git repository."
fi
log "Project directory: ${PROJECT_DIR}"

DATASOURCE_DIR="${PROJECT_DIR}/datasources/"
log "Datasource directory: ${DATASOURCE_DIR}"

REPO_URL="git@github.com:sky-uk/core-platform-config.git"
CLONE_DIR="../core-platform-config"

if [ -d "$CLONE_DIR" ]; then
    log "Repository already cloned, pulling latest changes."
    git -C "$CLONE_DIR" fetch --all
    git -C "$CLONE_DIR" reset --hard origin/master
else
    log "Cloning repository."
    git clone --recurse-submodules "$REPO_URL" "$CLONE_DIR"
    if [ $? -ne 0 ]; then
        exit_with_error "Failed to clone the repository."
    fi
    log "Successfully cloned the repository."
fi

cd "$CLONE_DIR" || exit_with_error "Failed to change directory to clone location."
git checkout master
if [ $? -ne 0 ]; then
    exit_with_error "Failed to checkout the master branch."
fi
log "Checked out the latest commit on the master branch."

mkdir -p "${DATASOURCE_DIR}"
if [ $? -ne 0 ]; then
    exit_with_error "Could not create datasources directory."
fi
log "Datasource directory created."

cp -r "${CLONE_DIR}"/grafana-datasources/datasources/{alto,arcus,core,eleos,kraken,kronos,lakitu,loki,nova,ovp-teams-federate,pulsar}* "${DATASOURCE_DIR}"
if [ $? -ne 0 ]; then
    exit_with_error "Could not copy files from source to datasource directory."
fi
log "Files successfully cloned to ${DATASOURCE_DIR}."
