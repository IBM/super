#!/usr/bin/env python3

from collections import Counter
import gzip
import re
import io
import ray
import json
import datetime

ray.init()
@ray.remote
def count_servers(lines):
    server_counts=Counter()
    for line in lines:
        text = line.decode("utf8")
        if re.search("^{\"Container", text):
            try:
                record = json.loads(text)
                meta = record["Envelope"]["Payload-Metadata"]
                if "HTTP-Response-Metadata" in meta:
                    response_meta = meta["HTTP-Response-Metadata"]
                    if "Headers" in response_meta:
                        headers = response_meta["Headers"]
                        if "Server" in headers:
                            server = headers["Server"]
                            if server:
                                server_key = re.sub('[/-].+$', '', server).lower()
                                server_counts[server_key] = server_counts[server_key] + 1
            except ValueError as e:
                continue
    return server_counts

begin=begin = datetime.datetime.now()
bufsize = 10000000
results = []
file = r"CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz"
file = r"CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz"
file = r"yo.wat.gz"
file=r"CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz"
with gzip.open(file, "r") as infile:
    while True:
        lines = infile.readlines(bufsize)
        lines_id = ray.put(lines)
        if not lines:
            break
        results.append(count_servers.remote(lines_id))
counts=ray.get(results)

server_counts = Counter()
for count in counts:
    server_counts.update(count)
end=datetime.datetime.now()

for word in server_counts.most_common(10):
    print("  ", word)
duration=end-begin

print(duration)
