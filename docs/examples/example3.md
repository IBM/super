# Super Power 3: High-performance Data Pipelines in the Cloud

<img src="images/runvis3.png" align="left" height="125">

UNIX pipelines perform incredibly well, and let you mix and match
off-the-shelf tools in flexible ways.  With Super, you can leverage
all of this power. Use high-performance UNIX pipes `|`, but against
Cloud data and compute.

<br>

## Example

Following on from [our previous `cp` example](example2.md#example),
this `super run` will spawn 3 jobs and produce the word count output
on your console. Here we are using off-the-shelf tools (`grep` and
`wc`), but in the Cloud, to compute a partial sum of matches.

```sh
super run -- 'cat /s3/ibm/tmp/*.wet.gz | gunzip -c - | grep "WARC-Type: conversion" | wc -l'
[Job 1] 40711
[Job 2] 40880
[Job 3] 40681
```

## Other Super Powers

<!--[<img src="images/runvis3.png" height="77">](example3.md)-->
[<img src="images/runvis1.png" height="77">](example1.md)
[<img src="images/runvis2.png" height="77">](example2.md)
[<img src="images/runvis4.png" height="77">](example4.md)
[<img src="images/runvis5.png" height="77">](example5.md)
