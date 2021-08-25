# Bash wordcount

All implementations read in a local compressed WET file.

- [**plainbash.sh**](plainbash) filters out trivial words
- [**parallelbash.sh**](parallelbash.sh) same, but uses GNU Parallel

## Usage

```sh
if [ ! -f ../CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz ]; then curl -LO https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2017-04/segments/1484560280292.50/wet/CC-MAIN-20170116095120-00055-ip-10-171-10-70.ec2.internal.warc.wet.gz; fi
./run.sh ./plainbash.sh
./run.sh ./parallelbash.sh
```