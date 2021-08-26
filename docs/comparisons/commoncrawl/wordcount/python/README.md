# Plain Python wordcount

All implementations read in a local compressed WET file.

- [**wordcount1.py**](wordcount1.py) filters out trivial words, using inefficient parsing of one line at a time in a loop
- [**wordcount2.py**](wordcount2.py) no filtering, and inefficiently reading one line at a time in a loop
- [**wordcount3.py**](wordcount3.py) no filtering, and more efficiently using Python loop-free parsing

TODO: Surely can we do filtering in Python in a loop-free way?

## Usage

```sh
if [ ! -f ../CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz ]; then (cd .. && curl -LO https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2017-04/segments/1484560280292.50/wet/CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz); fi
./run.sh ./wordcount1.py
./run.sh ./wordcount2.py
./run.sh ./wordcount3.py
```
