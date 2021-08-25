#!/usr/bin/env python3

from collections import Counter
import gzip
import re
from io import BufferedReader

file = r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz"
with gzip.open(file, "r") as gz, BufferedReader(gz, buffer_size=40000096) as f:
    wordcounts = Counter(f.read().split())

#most_frequent_words = heapq.nlargest(
#    10, wordcounts, key=wordcounts.get)
for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])
