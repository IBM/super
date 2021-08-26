#!/usr/bin/env python3

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
        idx = text.index('{')
        if idx >= 0:
            try:
                record = json.loads(text[idx:])
                if "languages" in record:
                    languages = record["languages"]
                    if languages:
                        language_counts.update(Counter(languages.split(",")))
            except ValueError as e:
                continue
                                

for word in language_counts.most_common(10):
    print("  ", word)
