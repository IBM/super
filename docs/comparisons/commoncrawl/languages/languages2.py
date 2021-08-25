from collections import Counter
import gzip
import re
import io
import json

file = r"cdx-00210.gz"

language_counts = Counter()
with gzip.open(file, "r") as gz, io.BufferedReader(gz) as f:
    for line in f:
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
                                

for word in language_counts.most_common(10):
    print("  ", word)
