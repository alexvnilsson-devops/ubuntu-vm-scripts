#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

export STARTUP_IN_PRODUCTION=1

REPO_LOCAL_PATH=/usr/local/etc/ubuntu-vm-scripts

if [[ ! -d "$REPO_LOCAL_PATH/.git" ]]; then
    # Only make directory and clone if Git-repo is not already in destination.

    mkdir -p /usr/local/etc/ubuntu-vm-scripts
    git clone https://github.com/alexvnilsson-devops/ubuntu-vm-scripts "${REPO_LOCAL_PATH}"
    cd "${REPO_LOCAL_PATH}"
else
    # Pull updates from Git remote, instead of force-removing contents in destination.

    cd "${REPO_LOCAL_PATH}"
    git pull
fi

bash "${SCRIPTPATH}/scripts/init.sh"