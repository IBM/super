# Ray wordcount

Unless otherwise stated, all implementations read in a local
compressed WET file.

- [**wordcount.py**](wordcount.py) No filtering. Uses Ray iterators.
- [**wordcount2.py**](wordcount2.py) No filtering. Uses ray.put.
- [**wordcount2-with-filtering.py**](wordcount2-with-filtering.py) Ibid, plus filters out trivial words.
- [**wordcount2-with-filtering-defaultdict.py**](wordcount2-with-filtering-defaultdict.py) Ibid, using defaultdict instead of Counter.
- [**wordcount2-with-filtering-and-minio.py**](wordcount2-with-filtering-defaultdict.py) As with wordcount2-with-filtering, but including the fetch of a remote input file.

## Usage

```sh
if [ ! -f ../CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz ]; then (cd .. && curl -LO https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2017-04/segments/1484560280292.50/wet/CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz); fi
./run.sh ./wordcount2.py
```
