export LC_ALL=C

IN=CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz

cat $IN | \
    gunzip -c - | \
    parallel -j 150% --pipe --linebuffer --block 10M grep --binary-files=text -Ev \'^WARC\|Content-\' \| ./wordsplit \| grep --binary-files=text ..... \| grep --binary-files=text -v \'[^a-zA-Z]\' \| tr [:upper:] [:lower:] \| ./histo | \
    ./histo2 | \
    sort -n -r | \
    head
