#!/usr/bin/env bash

F=cdx-00210.gz

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
cd "$SCRIPTDIR"

if [ ! -f $F ]; then
    curl -L https://commoncrawl.s3.amazonaws.com/cc-index/collections/CC-MAIN-2021-10/indexes/$F | gunzip -c - | gzip -c > $F
fi
