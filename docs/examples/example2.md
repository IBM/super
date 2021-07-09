# Super Example 2: Auto-scaling across a set of Cloud Data

<img src="images/runvis2.png" align="left" height="150">

Super can auto-scale across a glob pattern of Cloud data. In this
case, the glob will expand to 3 files, hence Super will spawn <= 3
Cloud jobs to host the copy. No need to set up VMs nor to transfer the
data to and from your laptop.

You may copy your files to any `/s3/...` path. Here, we use the
convenience `/s3/ibm/tmp` path that Super provides.

```sh
super run -- cp \
  '/s3/aws/commoncrawl/crawl-data/CC-MAIN-2021-21/segments/1620243992721.31/wet/*-0000{1,2,3}.warc.wet.gz' \
  /s3/ibm/tmp
```

Super desugars this `cp` into the equivalent `cat /s3/... >
/s3/ibm/tmp` form. You can use `>` to redirect output more generally,
such as in the following example:

## Cloud Redirects via `>`

Super pipelines also handle redirects to Cloud storage. This example
will redirect the output to N output files in the given dst bucket.
Have some fun! Fill in our own ideas for the ... part of this
pipeline.

```sh
super mkdir /s3/ibm/tmp/dst
super run -- 'gunzip -c /s3/ibm/tmp/*.gz | ... > /s3/ibm/tmp/dst/out-$j.txt'
```
