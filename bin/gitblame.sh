#!/bin/bash

#echo "=========================================="
#echo "Git show after blaming and choosing the commit"
#echo "=========================================="
#echo

#@ usage: gitblame.sh -C <repo> blame -L<line>,+<range> <file>
#@ author: Hieu Tran
#@ email : hieu@tuxera.com

PROGNAME=${0##*/}

# Expect at least 5 arguments
# E.g.: -C <repo> blame -L<line>,+<range> [commit] <file>
if [ $# -lt 5 ]; then
    echo "Wrong number of arguments"
    exit 1
fi
REPO="$2"

selected=$( git $* | fzf --no-mouse --no-sort --cycle --reverse )
[ -z "$selected" ] && echo "Nothing is chosen" && exit 0
COMMIT=${selected%% *}
git -C "$REPO" show "$COMMIT"
