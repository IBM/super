#!/usr/bin/env python3

import ray
import glob
import gzip
import heapq
from collections import Counter

ray.init()

with gzip.open(r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz", "r") as f:
    it = (
        ray.util.iter.from_items(f, num_shards=4)
       .for_each(lambda line: Counter(line.split()))
       .batch(1024)
)

wordcounts = Counter()
for counts in it.gather_async():
    for count in counts:
        wordcounts.update(count)
    
for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])

