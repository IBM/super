export LC_ALL=C

IN=CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz

cat $IN | \
    gunzip -c - | \
    grep --binary-files=text -Ev '^WARC|Content-' | \
    tr ' ' '\012' | \
    grep --binary-files=text ..... | \
    grep --binary-files=text -v '[^a-zA-Z]' | \
    tr [:upper:] [:lower:] | \
    ./histo | \
    sort -n -r | \
    head
