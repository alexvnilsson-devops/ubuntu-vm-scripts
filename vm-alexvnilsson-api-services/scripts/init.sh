#!/bin/bash
set -e

STARTUP_INSTANCE_FILENAME=.vminstance

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

export ALEXVNILSSON_API_SERVICES_PRODUCTION=${0:-$STARTUP_IN_PRODUCTION}
export STARTUP_INSTANCE_ROOT=$(realpath "${SCRIPTPATH}/..")
export STARTUP_INSTANCE_SCRIPTS_ROOT=$(realpath "${SCRIPTPATH}")

if [[ ! -f "$STARTUP_INSTANCE_ROOT/$STARTUP_INSTANCE_FILENAME" ]]; then
    echo -e "\e[31mMissing (or incorrect path to) VM-instance directory. Expecting to find ${STARTUP_INSTANCE_FILENAME} in ${STARTUP_INSTANCE_ROOT}\e[39m"
    exit 1
else
    . $STARTUP_INSTANCE_ROOT/$STARTUP_INSTANCE_FILENAME
    echo -e "\e[32mInitializing VM-instance \e[39m\e[1m${INSTANCE_NAME}\e[0m..."
fi

if [[ $ALEXVNILSSON_API_SERVICES_PRODUCTION = 1 ]]; then
    if [ "$EUID" -ne 0 ]; then
        echo -e "\e[31mThis script must be run with elevated permissions (sudo/root).\e[39m"
        exit 1
    fi
fi

bash "${STARTUP_INSTANCE_SCRIPTS_ROOT}/init/nginx.sh"
# bash "${STARTUP_INSTANCE_SCRIPTS_ROOT}/init/nodejs.sh"
# bash "${STARTUP_INSTANCE_SCRIPTS_ROOT}/init/ssl.sh"