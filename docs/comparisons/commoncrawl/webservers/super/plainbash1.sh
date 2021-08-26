export LC_ALL=C

IN=CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz
IN=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz
IN=yo.wat.gz
IN=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz

cat $IN | \
    gunzip -c - | \
    grep -F \"Envelope | \
    grep -F \"Server | \
    jq -r '.Envelope."Payload-Metadata"."HTTP-Response-Metadata"."Headers".Server' | \
    grep -o '^[^/]\+' | \
    tr '[:upper:]' '[:lower:]' | \
    ./histo | \
    head
