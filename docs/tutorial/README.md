### Table Of Contents

- [Running UNIX Commands in the Cloud](./README.md#readme) **[You are here]**
- [Interacting with Cloud Object Storage](./super-cos.md#readme)
- [Visually Browsing Cloud Object Storage](./super-browse.md#readme)
- [Parallelizing your UNIX Pipeline](./super-parallelism.md#readme)
- [Injecting Custom Binaries](./super-cloudbin.md#readme)
- [Examples of parallel analytics against CommonCrawl data](../blogs/2-Super-Examples/README.md#readme)
- [Automating Periodic Tasks](./super-every.md)
- [The Super Dashboard](./super-dashboard.md#readme)

# The Super Way to Run your UNIX Commands in the Cloud

**Super** allows you to run a UNIX command line *in parallel*, using
auto-scaling Cloud compute resources, against a set of Cloud data.
Super takes care of provisioning the right amount of compute, memory,
and disk capacity, scheduling your jobs, granting the needed data
access authority to your work, and streaming out logs --- all in one
command: `super run`.

Super uses containers running in IBM Cloud [Code
Engine](https://www.ibm.com/cloud/code-engine) as the compute layer,
and gives your jobs access to data via IBM [Cloud Object
Storage](https://www.ibm.com/cloud/object-storage).

This document demonstrates how to use `super run` via examples ranging
from data preparation tasks to more complex analytics. <!--
Separately, you may be interested in the [detailed usage guide for
`super run`](./super-run.md). -->

## Getting Started with a Few Simple Examples

> **Note**: Make sure to verify you are good to go, by first running
> [`super up`](./super-up.md).

The command `lscpu` provides information about the CPU your on which
your command executes. Using `super run`, we can easily run this in
the Cloud. Behind the scenes, CPU resources will automatically be spun
up and torn down, without your having to worry about anything beyond
the commands you wish to execute:

```sh
❯ super run -- lscpu
Architecture: ...
```

You can also link together commands into pipelines, in the normal
[UNIX way](https://en.wikipedia.org/wiki/Unix_philosophy). For
example, to extract the CPU model, you can pipe through
[`grep`](https://en.wikipedia.org/wiki/Grep) to filter the output:

```sh
❯ super run -- 'lscpu | grep "Model name"'
Model name:                      Intel Core Processor (Broadwell, IBRS)
```

> **Note:** Surround your command with `'single quotes'` to ensure
> that the `|` is executed in the Cloud, not your laptop.

### Specifying CPU and Memory Allocations

Your Cloud pipelines are given a default allocation of CPU shares and
phystical memory: 1 (whole) CPU and 4G of memory.  If the default
settings prove insufficient for your needs, then the `--cpu` and
`--memory` options can help:

```sh
super run --cpu 4 --memory=8G -- lscpu
```

> Notes: Your memory allocation request must be specified in "M/G"
units, not "Mi/Gi" units. Only certain cpu-to-memory ratios are
supported, due to the way IBM CodeEngine is designed. Consult [this
page](https://cloud.ibm.com/docs/codeengine?topic=codeengine-mem-cpu-combo)
for a list of supported combinations.


<!--## Others

```sh
super run -p 30  -- 'yes hello world | dd bs=1000024 count=100000 | mc pipe /s3/ibm/us/south/pdata/data${JOB_INDEX}.txt'
``` -->
