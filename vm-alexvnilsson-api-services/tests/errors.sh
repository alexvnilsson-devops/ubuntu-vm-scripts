#!/bin/bash
#set -x

run_command() {
    re=0
    error=$1
    re=$?

    if [[ $re = 0 ]]; then
        return 1
    else
        return 0
    fi
}

halt_progress() {
    echo -e "\e[31mInitialization process halted!\e[39m"

    if [[ ! -z $1 ]]; then
        echo $1
    fi

    if [[ ! -z $2 ]]; then
        echo $2
    fi

    exit ${3:-1}
}

command_test_failure() {
    re=0
    error=$( nginx -t )
    re=$?

    if [[ $re > 0 ]]; then
        halt_progress "Nginx configuration not OK." "${error}" 1
    fi

    return 0
}

command_test_success() {
    error=$( sudo nginx -t &2>1 )
    result=$?
    echo $result
    
    if [[ $result > 0 ]]; then
        halt_progress "Nginx configuration not OK." "${error}" 1
    fi

    return 0
}

run_command echo "no"; exit 1