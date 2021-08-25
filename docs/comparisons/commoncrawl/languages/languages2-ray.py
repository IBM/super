from collections import Counter
import gzip
import re
import io
import ray
import json
import datetime

ray.init()
@ray.remote
def count_languages(lines):
    language_counts=Counter()
    for line in lines:
        text = line.decode("utf8")
        try:
            idx = text.rindex('"languages"')
            if idx >= 0:
                idx2 = idx + 14
                idx3 = text.index('"', idx2)
                languages = text[idx2:idx3]
                language_counts.update(Counter(languages.split(",")))
        except ValueError as e:
            continue
    return language_counts

begin=begin = datetime.datetime.now()
bufsize = 10000000
results = []
file = r"cdx-00210.gz"
#file = r"yo.gz"
with gzip.open(file, "r") as infile:
    while True:
        lines = infile.readlines(bufsize)
        lines_id = ray.put(lines)
        if not lines:
            break
        results.append(count_languages.remote(lines_id))
counts=ray.get(results)

language_counts = Counter()
for count in counts:
    language_counts.update(count)
end=datetime.datetime.now()

for word in language_counts.most_common(10):
    print("  ", word)
duration=end-begin

print(duration)
