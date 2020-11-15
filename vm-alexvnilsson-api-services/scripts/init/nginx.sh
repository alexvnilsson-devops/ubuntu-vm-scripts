#!/bin/bash

#
#
# arg. 1: error message
# arg. 2: stderr from command.
# arg. 3: exit code (optional, default: 1)
halt_progress() {
    echo -e "\e[31mInitialization process halted!\e[39m"

    if [[ ! -z $1 ]]; then
        echo $1
    fi

    exit ${3:-1}
}


#
# Module functions
#

# Test nginx config.
nginx_config_test() {
    re=0
    error=$( nginx -t )
    re=$?

    if [[ $re > 0 ]]; then
        halt_progress "Nginx configuration not OK." "${error}" 1
    fi
}

# Reload nginx service.
nginx_service_reload() {
    re=0
    error=$( service nginx reload )
    re=$?

    if [[ $re > 0 ]]; then
        halt_progress "Nginx could not be reloaded/restarted." "${error}" 1
    fi
}


#
# END Module functions
#

NGINX_CONF_ROOT=/etc/nginx

if [[ $ALEXVNILSSON_API_SERVICES_PRODUCTION = 1 ]]; then
    # Production-environment

    apt install --yes nginx

    cp "${STARTUP_INSTANCE_ROOT}/data/nginx/sites-available/${NGINX_CONF_FILENAME}" "${NGINX_CONF_ROOT}/sites-available/${NGINX_CONF_FILENAME}"
    ln -s "${NGINX_CONF_ROOT}/sites-available/${NGINX_CONF_FILENAME}" "${NGINX_CONF_ROOT}/sites-enabled/"

    nginx_config_test
    nginx_service_reload
else
    # Development-environment

    apt install --yes --dry-run nginx
fi

#cp "${INSTANCE_ROOT}/data"
