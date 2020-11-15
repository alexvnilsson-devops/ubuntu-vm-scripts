#!/bin/bash

echo $ALEXVNILSSON_API_SERVICES_PRODUCTION

INSTANCE_ROOT="${STARTUP_INSTANCE_ROOT}"

if [[ ! -f "$INSTANCE_ROOT/.vminstance" ]]; then
    echo "Incorrect path."
    exit 1
fi

if [[ $ALEXVNILSSON_API_SERVICES_PRODUCTION = 1 ]]; then
    echo "Environment: production."

    apt install --yes nginx
else
    echo "Environment: development."

    apt install --yes --dry-run nginx
fi

#apt install --yes nginx

#cp "${INSTANCE_ROOT}/data"
