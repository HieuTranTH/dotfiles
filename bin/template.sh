#!/usr/bin/env bash

source box.sh
box "abcdefgh"

#@ usage: 
#@ author: Hieu Tran
#@ email : hieu.tran@upm.com

readonly PROGNAME=${0##*/}

## Default values
EXIT_FAILURE=1
VERBOSE=${VERBOSE:-0}
FILENAME=

function usage() {
    echo -e "$PROGNAME - \n"
    echo -e "usage: $PROGNAME [-v] [-h] [-?]\n"
    echo -e "   -v: Verbose mode."
    echo -e "   -h: Print this help message."
    echo -e "   -?: Print this help message."
}

function die() {
    echo "ERROR: $*" >&2
    exit $EXIT_FAILURE
}

function log {
    [ ${VERBOSE} -eq 0 ] && return 0
    local readonly level="$1"
    local readonly message="$2"
    local readonly timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    >&2 echo -e "${timestamp} [${level}] [$PROGNAME] ${message}"
}

function log_info {
    local readonly message="$1"
    log "INFO" "$message"
}

function log_warn {
    local readonly message="$1"
    log "WARN" "$message"
}

function log_error {
    local readonly message="$1"
    log "ERROR" "$message"
}


## List of options the program will accept;
## those options that take arguments are followed by a colon
OPTSTRING='f:vh?'

## The loop calls getopts until there are no more options on the command line
## Each option is stored in $OPT, any option arguments are stored in OPTARG
while getopts "$OPTSTRING" OPT
do
    case $OPT in
        f)
            FILENAME=$OPTARG ## $OPTARG contains the argument to the option
            ;;
        v)
            VERBOSE=$(( VERBOSE + 1 ))
            ;;
        *)
            usage >&2
            exit $EXIT_FAILURE
            ;;
    esac
done

## Remove options from the command line
## $OPTIND points to the next, unparsed argument
shift "$(( OPTIND - 1 ))"
