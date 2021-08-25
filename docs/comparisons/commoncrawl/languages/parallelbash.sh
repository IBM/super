export LC_ALL=C

KEY=languages

IN=cdx-00210.gz
#IN=yo.gz

#export PATH=/home/nickm/rust-parallel/parallel-master/target/x86_64-unknown-linux-musl/release:$PATH

cat $IN | \
    gunzip -c - | \
    parallel -j 150% --pipe --linebuffer --block 20M grep -F \'\"languages\":\' \| \
    ./lang.sh \| \
    tr -d \' \"}\' \| \
    tr -d \' \"\' \| \
    tr \',\' \'\\012\' \| \
    ../histo | \
    ../histo2 | \
    sort -n -r | \
    head

