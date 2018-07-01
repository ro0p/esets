#!/bin/bash

set -o functrace

LOGGER_DEBUG=${LOGGER_DEBUG:-0}
LOGGER_OUTPUT=${LOGGER_OUTPUT:-/dev/stderr}

function log() {
    exit_code=${LOGGER_EXITCODE:-1}
    unset LOGGER_EXITCODE
    msg=""
    test -s /dev/stdin && msg=$(< /dev/stdin)
    level="info"
    src=($(caller))
    if [ -n "$msg" ]; then
	[ -n "$1" ] && level="$1"
    else
	if [ "$#" -gt 1 ]; then
	    level="$1"
	    shift
	    msg="$@"
	else
	    msg="$@"
	fi
    fi
    [ -z "$msg" ] && return
    [ "$level" == "debug" ] && [ $LOGGER_DEBUG -ne 1 ] && return
    date=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${date} $(basename ${src[1]}):${src[0]} [${level}] ${msg[@]}" >> $LOGGER_OUTPUT
    if [ "$level" == "die" ]; then
	trap "kill -9 $PPID; exit 1" EXIT
    fi
    if [ "$level" == "error" ] || [ "$level" == "die" ]; then
	exit ${exit_code}
    fi
}
