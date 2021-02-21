#!/bin/bash

echo "==========================================="
echo "Check changes i3xrocks conf.d files between"
echo "default in /etc/regolith/i3xrocks/conf.d"
echo "user in ~/.config/regolith/i3xrocks/conf.d"
echo "==========================================="
echo
#@ usage: i3xrocks-check-conf.d-changes.sh [DEFAULT_DIR] [USER_DIR]

DEFAULT_DIR=${1:-/etc/regolith/i3xrocks/conf.d}
USER_DIR=${2:-~/.config/regolith/i3xrocks/conf.d}

for USER_FILE in ${USER_DIR}/*; do
    BASE=$( basename ${USER_FILE} )
    BASE=${BASE##*_}
    DEFAULT_FILE=${DEFAULT_DIR}/*_$BASE
    if [ -f ${DEFAULT_FILE} ]; then
        if ! diff ${DEFAULT_FILE} ${USER_FILE} > /dev/null; then
            diff2less ${DEFAULT_FILE} ${USER_FILE}
        fi
    fi
done


#echo "------------------------"
#echo $DEFAULT_DIR
#echo $USER_DIR
