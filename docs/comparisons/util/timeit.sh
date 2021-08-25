#!/bin/bash

# This script requires GNU date. On macOS you may `brew install
# coreutils`, which provides `gdate`. This script assumes you have
# done so.

if [[ uname = Darwin ]]; then
    DATE=gdate
else
    # this also assumes that you have installed coredutils for linux
    # and other platforms; it's just that, on macOS, the installed
    # utility is called `gdate`.
    DATE=/usr/bin/date
fi

ts=$($DATE +%s%N)
$@
tt=$((($($DATE +%s%N) - $ts)/1000000))
echo $tt
