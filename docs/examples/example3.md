# Super Example 3: Pipelines in the Cloud

<img src="images/runvis3.png" align="left" height="125">

Super pipelines are normal UNIX pipelines. Use high-performance UNIX
pipes `|`, but against Cloud data and compute.  This again will spawn
3 jobs and produce the word count output on your console. Here we are
using grep and wc in the Cloud to compute a partial sum of matches.

<br>

```sh
super run -- 'cat /s3/ibm/tmp/*.wet.gz | gunzip -c - | grep "WARC-Type: conversion" | wc -l'
[Job 1] 40711
[Job 2] 40880
[Job 3] 40681
```

