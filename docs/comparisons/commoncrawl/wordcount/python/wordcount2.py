#!/usr/bin/env python3

from collections import Counter
import gzip
import re
#import io

wordcounts = Counter()
file = r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz"
#with gzip.open(file, "r") as gz, io.BufferedReader(gz, buffer_size=40000096) as f:
with gzip.open(file, "r") as f:
    for line in f:
        wordcounts.update(line.split())

# wordcount = Counter(file.read().split())
#most_frequent_words = heapq.nlargest(
#    10, wordcounts, key=wordcounts.get)
#for word in most_frequent_words:
for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])
