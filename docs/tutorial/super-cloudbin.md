### Table Of Contents

- [Running UNIX Commands in the Cloud](./README.md#readme)
- [Interacting with Cloud Object Storage](./super-cos.md#readme)
- [Visually Browsing Cloud Object Storage](./super-browse.md#readme)
- [Parallelizing your UNIX Pipeline](./super-parallelism.md#readme)
- [Injecting Custom Binaries](./super-cloudbin.md#readme) **[You are here]**
- [Examples of parallel analytics against CommonCrawl data](../blogs/2-Super-Examples/README.md#readme)
- [Automating Periodic Tasks](./super-every.md)
- [The Super Dashboard](./super-dashboard.md#readme)

# The Super Way to Inject Custom Binaries into Cloud Executions

So far, we have described how to execute a UNIX pipeline using
built-in tools such as `grep` and `sed`, and using `|` and `>` and `;`
to sequence your computations. If you find this restriction to the use
of built-ins limiting, Super has a solution: a Cloud analog to
`/usr/local/bin`.

Locally, this would be a directory in which you install custom
binaries, such as `kubectl`, that don't ship with your operating
system. We would benefit from the same, but for Cloud-based
executions.

At the moment, this approach is limited to the injection of scripts
and binaries that self-contain their dependencies --- no `pip` or
`npm` management, yet.

With that restriction, you may inject custom shell scripts and
Linux-amd64 binaries by:

1. Copy your custom binaries to a Cloud Object Storage filepath:

```sh
super mkdir /s3/ibm/default/cloudbin
super cp analyze.sh /s3/ibm/default/cloudbin
```

> **Note**: you will need to choose your own bucket name (do not use
> "cloudbin"), as bucket names are global, across all users.

2. Now you may use that binary in your Cloud pipelines:

```sh
super run --- gunzip -c /s3/ibm/default/mydata/*.txt.gz | /s3/ibm/default/cloudbin/analyze.sh
```

And that's it!
