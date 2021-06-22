### Table Of Contents

- [Running UNIX Commands in the Cloud](./README.md#readme)
- [Interacting with Cloud Object Storage](./super-cos.md#readme) **[You are here]**
- [Visually Browsing Cloud Object Storage](./super-browse.md#readme)
- [Parallelizing your UNIX Pipeline](./super-parallelism.md#readme)
- [Injecting Custom Binaries](./super-cloudbin.md#readme)
- [Examples of parallel analytics against CommonCrawl data](../blogs/2-Super-Examples/README.md#readme)
- [Automating Periodic Tasks](./super-every.md)
- [The Super Dashboard](./super-dashboard.md#readme)

# The Super Way to Interact with Cloud Object Storage

> **Note**: Make sure to verify you are good to go, by first running
> [`super up`](./super-up.md).

You may use filepaths of the form `/s3/ibm/...` to specify folders
within your Cloud Object Storage. Most normal filesystem commands will
work against these filepaths: `cat`, `ls`, `head`, `mkdir`, etc. You
may then use `super run` to read data from and write data to storage
that persists beyond the execution of your Cloud jobs.

To list all buckets in your default IBM Cloud region:

```sh
super run -- ls /s3/ibm/default
```

## Local commands for interacting with Cloud Object Storage

In some cases, there is no need to execute object storage requests in
the Cloud. For example, if you only wish to list objects, or create
buckets and folders, you may also choose to execute these simple
operations on your laptop:

```sh
❯ super mkdir /s3/ibm/default/superfun
❯ super cp /usr/share/dict/words /s3/ibm/default/superfun
❯ super ls /s3/ibm/default/superfun
words
```

> **Note:** You must choose your own name for the bucket (do not use
> "superfun"). Bucket names are global, across all users.

<!-- The first command is run on your laptop, and creates a directory
called `superfun` in the default region of your IBM Cloud Object
Storage. -->

## Redirecting output to Cloud Object Storage

You may also leverage the standard UNIX `>` operator to redirect the
output of your Cloud pipelines, and have this output persisted. In
this way, the data created by your Cloud pipeline will survive the
execution of the Cloud job.

```sh
super run -p5 -- 'echo hello > /s3/ibm/default/superfun'
```

This command runs 5 jobs in the Cloud. The output of the `echo`
command will be stored in a corresponding set of 5 files within
"superfun", named by the `JOB_INDEX` of each parallel task.
