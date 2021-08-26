export LC_ALL=C
IN=CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz

cat $IN | \
    unpigz -c - | \
    parallel -j 150% --pipe --linebuffer --block 10M grep \'^{\"Container\' \| grep -Eo \'\"Server\":\"[^\"]+\"\' \| sed -E -e \'s/\"Server\":\|\"//g\' \| \
    grep -o \'^[^/-]\\+\' \| \
    tr [:upper:] [:lower:] | \
    ../histo | \
    ../histo2 | \
    sort -n -r | \
    head
