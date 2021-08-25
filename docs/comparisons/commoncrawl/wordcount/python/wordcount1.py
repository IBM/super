#!/usr/bin/env python3

from collections import Counter
import gzip
import re
import io

wordcounts = Counter()
file = r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz"
with gzip.open(file, "r") as gz, io.BufferedReader(gz) as f:
    for line in f:
        text = line.decode("utf8")
        if not re.search("^WARC|Content-", text):
            for word in text.split():
                if len(word) >= 5 and not re.search('[^a-zA-Z]', word):
                    #wordcounts.update([word])
                    wordcounts[word.lower()] += 1

#most_frequent_words = heapq.nlargest(
#    10, wordcounts, key=wordcounts.get)
#for word in most_frequent_words:
for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])
