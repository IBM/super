#!/usr/bin/env bash

F=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
cd "$SCRIPTDIR"

if [ ! -f CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz ]; then
    curl -L https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2021-10/segments/1614178369553.75/wat/$F | gunzip -c - | gzip -c > $F
fi
