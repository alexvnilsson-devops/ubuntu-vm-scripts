#!/bin/bash

mkdir -p /tmp

curl -sL https://deb.nodesource.com/setup_14.x -o /tmp/nodesource_setup.sh && bash /tmp/nodesource_setup.sh && apt install nodejs gcc g++ make --yes