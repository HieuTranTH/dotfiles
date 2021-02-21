#!/bin/bash

echo "==========================================="
echo "Check changes i3xrocks blocklets files between"
echo "default in /usr/share/i3xrocks"
echo "user in ~/.config/regolith/i3xrocks/blocklets"
echo "==========================================="
echo
#@ usage: i3xrocks-check-blocklets-changes.sh [DEFAULT_DIR] [USER_DIR]

DEFAULT_DIR=${1:-/usr/share/i3xrocks}
USER_DIR=${2:-~/.config/regolith/i3xrocks/blocklets}

for USER_FILE in ${USER_DIR}/*; do
    BASE=$( basename ${USER_FILE} )
    DEFAULT_FILE=${DEFAULT_DIR}/$BASE
    if [ -f ${DEFAULT_FILE} ]; then
        if ! diff ${DEFAULT_FILE} ${USER_FILE} > /dev/null; then
            diff2less ${DEFAULT_FILE} ${USER_FILE}
        fi
    fi
done


#echo "------------------------"
#echo $DEFAULT_DIR
#echo $USER_DIR
