# Startup-scripts for VM-instance vm-alexvnilsson-api-services

## System requirements

These scripts are written for Debian-based systems, currently officially supported for Ubuntu 18.04.5 LTS and up.

### Software requirements

These packages are required for these scripts to work:

- Git
- Aptitude

## What these scripts do

1. Installs packages
    - `nginx`
    - Node.js (and `gcc`, `g++`, `make`)
    - `Certbot`.
2. Configures services
    - nginx
        - Site configuration
        - Installs SSL-certificates with `Certbot`.
