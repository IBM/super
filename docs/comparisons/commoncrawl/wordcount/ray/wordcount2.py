#!/usr/bin/env python3

from collections import Counter, defaultdict
import gzip
import io
import ray
import pandas
import datetime
#file = open(r"CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet", "r", encoding="utf-8-sig")
ray.init()
wordcount=0
@ray.remote
def count_words(lines):
    count=0
    for line in lines:
        count = count + len(line.split())
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
numbers=ray.get(results)
for number in numbers:
    wordcount=wordcount+number
end=datetime.datetime.now()
duration=end-begin
print(wordcount)
print(duration)
