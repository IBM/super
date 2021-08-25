cat CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz  | \
    gunzip -c - | \
    grep -F \"Envelope | \
    grep -F \"Server | \
    parallel --pipe --linebuffer --block 10M -q jq -r '.Envelope."Payload-Metadata"."HTTP-Response-Metadata"."Headers".Server' | \
    grep -o '^[^/]\+' | \
    tr [:upper:] [:lower:] | \
    ../a.out | \
    head
