### Table Of Contents

- [Running UNIX Commands in the Cloud](./README.md#readme)
- [Interacting with Cloud Object Storage](./super-cos.md#readme)
- [Visually Browsing Cloud Object Storage](./super-browse.md#readme)
- [Parallelizing your UNIX Pipeline](./super-parallelism.md#readme) **[You are here]**
- [Injecting Custom Binaries](./super-cloudbin.md#readme)
- [Examples of parallel analytics against CommonCrawl data](../blogs/2-Super-CommonCrawl/README.md#readme)
- [Automating Periodic Tasks](./super-every.md)

# The Super Way to Parallelize your UNIX Pipeline

> **Note**: Make sure to verify you are good to go, by first running
> [`super up`](../../commands/super-up.md).

You probably desire to run many commands in parallel. Here, you have
two options:

1. run a given pipeline a fixed `N` number of times: [`super run -p<N> -- lscpu`](#parallelism-option-1-running-a-given-unix-pipeline-a-fixed-number-of-times)
2. run a given pipeline once for each of a set of input files: [`super run -- gunzip -c *.txt.gz | ...`](#parallelism-option-2-running-a-given-pipeline-once-for-each-of-a-set-of-input-files)

You may also need to [collect and
combine](#joining-the-results-of-parallel-job-execution) the results
of your parallel tasks.

## Parallelism Option 1: Running a given UNIX Pipeline a fixed number of times

If you wish to run a given UNIX pipeline a fixed number of times, use
the `-p` option.  For example, to execute our "Model name" pipeline 5
times in parallel, in the Cloud:

```sh
❯ super run -p5 -- 'lscpu | grep "Model name"'
[Job 4] Model name:                      Intel Core Processor (Broadwell, IBRS)
[Job 3] Model name:                      Intel Xeon Processor (Cascadelake)
[Job 1] Model name:                      Intel Core Processor (Broadwell, IBRS)
[Job 2] Model name:                      Intel Core Processor (Broadwell, IBRS)
[Job 5] Model name:                      Intel Core Processor (Broadwell, IBRS)
```

In this case, `super run` has prefixed the output with the index of
each of the five parallel jobs. Note how the job indices occur
out-of-order. This is because your jobs are executed in parallel.

> **Note:** Here we must surround our pipeline with 'single quotes',
> to ensure that the `|` is executed in the Cloud.

<!--You may use other UNIX constructs, such as `;`. To create the file
`test.txt` on each of the 5 containers, and then list them to verify
their existence (note how again the 'single quotes' are critical, so
that the `;` is executed in the Cloud, not your laptop):

```sh
❯ super run -p5 -- 'touch test.txt; ls test.txt'
test.txt
``` 
-->

### The JOB_INDEX environment variable

Each of the `N` parallel tasks is assigned an index in the range
`1..N`. This index is materialized in the environment variable
`JOB_INDEX`:
```
❯ super run -p5 -- 'touch test$JOB_INDEX.txt; ls test*'
[Job 2] test2.txt
[Job 4] test4.txt
[Job 3] test3.txt
[Job 1] test1.txt
[Job 5] test5.txt
```

> **Note:** Here again we must surround our pipeline with 'single
> quotes', to prevent expansion of the `$` environment variable
> reference prior to Cloud execution, and also to ensure that the `;`
> and `*` are executed in the Cloud.

## Joining the Results of Parallel Job Execution

You may wish to combine the outputs of your parallel jobs into a
single output. For example, we may want to combine the `lscpu | grep
"Model name"` output into a histogram. This pattern is useful for
*classification* tasks, where you want to group the input data into a
number of *classes*, and present the results as a histogram.

First, we can add `sed` to our pipeline to clean up the output a bit:

```sh
❯ super run -p 5 -- 'lscpu | grep "Model name" | sed "s/Model name:[ ]*//"'
[Job 4] Intel Core Processor (Broadwell, IBRS)
[Job 3] Intel Xeon Processor (Cascadelake)
[Job 1] Intel Core Processor (Broadwell, IBRS)
[Job 2] Intel Core Processor (Broadwell, IBRS)
[Job 5] Intel Core Processor (Broadwell, IBRS)
```

Then, we can feed the output of the Cloud jobs into a local histogrammer:

```sh
❯ super run -p 5 -- 'lscpu | grep "Model name" | sed "s/Model name:[ ]*//"' | sort | uniq -c
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    ^^^^^^^^^^^^^^
                                   Executed in the Cloud                      on your laptop
   4 Intel Core Processor (Broadwell, IBRS)
   1 Intel Xeon Processor (Cascadelake)
```

## Parallelism Option 2: Running a given pipeline once for each of a set of input files

If you need to apply the same analytics to a set of input files, Super
can help. If you specify a set of filepaths, either by explicitly
enumerating the input files, or by using
[glob](https://en.wikipedia.org/wiki/Glob_(programming)) patterns,
Super will automatically apply your command to each file.

```sh
❯ export DIR=/s3/aws/commoncrawl/crawl-data/CC-MAIN-2021-10/segments/1614178369553.75/wat
❯ super run -- \
  "gunzip -c $DIR/CC-MAIN-20210304235759-20210305025759-0000{1,2,3,4,5}.warc.wat.gz \
    | head"
[Job 5] WARC/1.0
[Job 5] WARC-Type: warcinfo
[Job 3] WARC/1.0
[Job 3] WARC-Type: warcinfo
[Job 1] WARC/1.0
[Job 1] WARC-Type: warcinfo
[Job 2] WARC/1.0
[Job 2] WARC-Type: warcinfo
```

Here, we have uncompressed and extracted the first two lines of 5
files from the [CommonCrawl](https://commoncrawl.org/) public data
set.

The "glob" pattern `foo{1,2,3,4,5}` expands to the tuple `foo1, foo2,
foo3, foo4, foo5`, and Super will parallelize across the matched
files.
