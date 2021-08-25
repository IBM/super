export LC_ALL=C

IN=CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz
IN=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz
IN=yo.wat.gz

cat $IN | \
    unpigz -c - | \
    grep '^{\"Container' | \
    grep -Eo '"Server":"[^"]+"' | sed -E -e 's/"Server":|"//g' | \
    grep -o '^[^/-]\+' | \
    tr [:upper:] [:lower:] | \
    ../histo | \
    sort -n -r | \
    head
