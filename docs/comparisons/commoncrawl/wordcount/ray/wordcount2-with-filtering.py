#!/usr/bin/env python3

from collections import Counter
import gzip
import re
import io
import ray
import pandas
import datetime

ray.init()
wordcount=0
@ray.remote
def count_words(lines):
    count=Counter()
    for line in lines:
        text = line.decode("utf8")
        if not re.search("^WARC|Content-", text):
            for word in text.split():
                if len(word) >= 5 and not re.search('[^a-zA-Z]', word):
                    count[word.lower()] += 1
    return count

begin=begin = datetime.datetime.now()
bufsize = 10000000
results = []
with gzip.open(r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz", "r") as infile: 
    while True:
        lines = infile.readlines(bufsize)
        lines_id = ray.put(lines)
        if not lines:
            break
        results.append(count_words.remote(lines_id))
counts=ray.get(results)

wordcounts = Counter()
for count in counts:
    wordcounts.update(count)

for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])
end=datetime.datetime.now()
duration=end-begin

print(duration)
