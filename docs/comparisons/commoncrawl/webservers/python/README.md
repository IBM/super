# Plain Python Web Server Classification

All implementations read in a local compressed WAT file.

- [**webservers.py**](webservers.py) Uses Python nested loops to classify by serving web server

TODO: Surely can we do filtering in Python in a loop-free way?

## Usage

```sh
if [ ! -f ../CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz ]; then (cd .. && curl -LO https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2021-10/segments/1614178369553.75/wat/CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz); fi
./run.sh ./webservers.py
```
