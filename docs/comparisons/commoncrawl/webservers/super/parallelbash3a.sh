export LC_ALL=C

# sed -En 's/.*"Server":"?([^,"]*)"?.*/\1/p'
# grep -zoP '"Server":"\K[^"]+' | \
    #    sed -n 's|.*"Server":"\([^"]*\)".*|\1|p' | \

KEY=Server
IN=CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz
IN=yo.wat
IN=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz

cat $IN | \
    grep -F '"Server' | \
    parallel -j ${1-6} --pipe --linebuffer --block 10M ./wat2 $KEY \| \
    tr -d \'\"\' \| \
    tr [:upper:] [:lower:] | \
    ../a.out | \
    head

