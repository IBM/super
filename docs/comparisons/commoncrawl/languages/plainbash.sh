export LC_ALL=C

KEY=languages

IN=cdx-00210.gz
#IN=yo.gz

#    grep -Eo "\"$KEY\": \"[^\"]+\"" | grep -Eo ' "[^"]+"' |
#    grep -Eo ' \{.+\}$' | jq .languages |
cat $IN | \
    gunzip -c - | \
    ./lang.sh | \
    tr -d ' "}' | \
    tr ',' '\012' | \
    ../a.out | \
    sort -n -r | \
    head
