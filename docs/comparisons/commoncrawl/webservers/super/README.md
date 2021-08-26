# Super/Bash Web Server Classification

All implementations read in a local compressed WAT file.

- [**plainbash1**](plainbash1.sh) Uses jq for projection (inefficient)
- [**plainbash2**](plainbash2.sh) Uses grep for projection
- [**plainbash3**](plainbash3.sh) Uses awk for projection

## Usage

```sh
if [ ! -f ../CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz ]; then (cd .. && curl -LO https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2021-10/segments/1614178369553.75/wat/CC-MAIN-20210304235759-20210305025759-00616.warc.wat.gz); fi
./run.sh ./plainbash1.sh
```
