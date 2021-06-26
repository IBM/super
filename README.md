#### [Examples](#examples)  | [Tutorials](#tutorials) | [Blogs](#blogs) | [Installation](#installation)

# Super: A CLI for the Serverless Supercomputer

**Super** runs a normal UNIX command line against Cloud data, using
Cloud compute resources. Super takes care of provisioning the right
amount of compute, memory, and disk capacity, scheduling your jobs,
granting the needed data access authority to your work, and streaming
out logs &mdash; all in one command: `super run`.

<img title="Super takes a normal UNIX command line, and runs it in parallel, in the Cloud" alt="Super auto-scales normal UNIX command lines" src="docs/blogs/1-Super-Overview/super-lscpu-100-with-progress.gif" align="right" width="550">

Super also automatically injects logic to track the progress of
**any** job against your Cloud data. You get helpful progress bars for
free.

<img title="Super can copy your Cloud data rapidly, across providers or regions within the Cloud" alt="Animated GIF of super copy" src="docs/blogs/1-Super-Overview/super-cp-5-with-progress.gif" align="right" width="550">

Super links Cloud compute from [IBM Cloud Code
Engine](https://www.ibm.com/cloud/code-engine) with Cloud data in any
S3 provider, such as [IBM Cloud Object
Storage](https://www.ibm.com/cloud/object-storage).

## Examples

```sh
# Super can run a fixed number of UNIX command lines, in the Cloud
super run -p10 -- printenv JOB_INDEX
```

```sh
# Super can auto-scale across a glob pattern of Cloud data
# If the *.txt.gz matches 50 files, Super will spawn <= 50 Cloud jobs
# to host the copy. No need to set up VMs or containers or transfer
# the data to and from your laptop.
super run -- cp /s3/ibm/us/south/src/*.txt.gz /s3/ibm/ap/jp/dst
```

```sh
# Super pipelines are normal UNIX pipelines; | works as expected, but
# against Cloud data, using Cloud compute. This again will spawn N jobs
# depending on the number of glob matches to the input files.
super run -- cat /s3/ibm/us/south/src/*.txt.gz | gunzip -c - | grep hello
```

```sh
# Super pipelines also handle redirects to Cloud storage. This example will
# create N output files in the given dst buckets.
super run -- cat /s3/ibm/us/south/src/*.txt.gz | ... > /s3/ibm/us/south/dst
```

```sh
# You may also inject custom scripts into the running jobs
super mkdir /s3/ibm/us/south/bin
super cp myAnalysis.sh /s3/ibm/us/south/bin
super run -- cat /s3/ibm/us/south/src/*.txt.gz | /s3/ibm/us/south/bin/myAnalysis.sh > /s3/ibm/us/south/dst
```

## Tutorials

- [Getting to Know Super](docs/tutorial/basics/#readme)

## Blogs

- [Exploring Big Data with a CLI](https://medium.com/the-graphical-terminal/exploring-big-data-with-a-cli-59af31d38756)
- [Bash the Cloud](docs/blogs/1-Super-Overview/README.md#readme)

## Installation

<img title="The super up command helps you with prerequisites" alt="The super up command helps you with prerequisites" src="docs/tutorial/basics/super-up.png" align="right" width="400">

The latest build of Super is available
[here](https://github.com/IBM/super/releases). After you have downloaded
your release:

```sh
tar jxf Super-darwin-x64.tar.bz2
export PATH=$PWD/Super-darwin-x64/Super.app/Contents/Resources:$PATH
super
```

You should now see usage information for Super, including the main
sub-commands:
- [`super up`](docs/commands/super-up.md)
- [`super run`](docs/commands/super-run.md)
- [`super dashboard`](docs/tutorial/basics/super-dashboard.md)
- [`super browse`](docs/tutorial/basics/super-browse.md)

We suggest first trying [`super up`](docs/commands/super-up.md), which
will validate your prerequisites. If you are good to go, then you can
try `super run -p5 -- echo hello`, which will execute that command as
five Cloud jobs. If this all looks good, then proceed to the
[**Getting to Know Super**](docs/tutorial/basics#readme) tutorial.
