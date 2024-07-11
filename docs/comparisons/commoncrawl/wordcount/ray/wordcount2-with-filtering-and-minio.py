#!/usr/bin/env python3

from collections import Counter, defaultdict
import gzip
import re
import io
import ray
import pandas
import datetime
from minio import Minio

client = Minio("s3.amazonaws.com", "", "")

ray.init()
#ray.init(address='auto')

wordcount=0
@ray.remote(num_cpus=1)
def count_words(lines):
    count=Counter()
    for line in lines:
        text = line.decode("utf8")
        if not re.search("^WARC|Content-", text):
            for word in text.split():
                if len(word) >= 5 and not re.search('[^a-zA-Z]', word):
                    count[word] = count[word] + 1
    return count

begin=begin = datetime.datetime.now()
bufsize = 10000000
results = []
response = client.get_object('commoncrawl', 'crawl-data/CC-MAIN-2017-04/segments/1484560280292.50/wet/CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz')
with gzip.GzipFile(fileobj=response) as infile:
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
end=datetime.datetime.now()

for word in wordcounts.most_common(10):
    print("  ", word, wordcounts[word])
duration=end-begin

print(duration)
