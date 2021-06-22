## Tasks at Hand

Many tasks these days revolve around making sense of large data
sets. Training models, analyzing log data, constructing business plans
based on usage characteristics. These tasks may require analyzing
video feeds or processing semi-structured text. A critical part of any
data analysis is the preparation phase. In this blog, we will show how
using **normal bash pipelines** can give you an interactive, and
surprisingly highly performant [1], way to process data in the
cloud. With this technique, you can bash data in the cloud, using bash
pipelines that are identical to what you would write when operating
against local data.

Before throwing your data at the model generator, you inevitably spend
a good amount of time learning the structure of the data, and then
massaging it into an agreeable form. The data sets can be giant, be
stored under cryptic filepaths in a variety of cloud object stores,
are often compressed, and encoded in domain-specific data formats. All
of these features of the data slow you down, before you can even get
started with processing it. I probably need to download giant files in
order to run them through some local tooling, to help me learn the
data formats, and to prototype a few passes of the code. Already, the
way I develop differs from the way I operate at scale.

finding and excluding outliers, projecting out
fields of interest, splitting or aggregating the data sets to
facilitate parallel processing, running the data through various
classifiers in order to facilitate downstream analytics, and so on.

# Outline notes:

- data is remote and encoded
- leads to divergent experiences while prototyping versus at scale
- data needs to be processed into forms amenable for downstream analytics
  - to facilitate parallelism
  - to accommodate format constraints of other systems, such as model generators
  - to filter and classify in a way that maximizes the efficacy of those systems
- data is large, but many processing tasks can be easily expressed as streaming data pipelines
  - streaming data pipelines are easy to parallelize
  - they run very efficiently in terms of memory consumption and data locality
  - streaming pipelines express 2-3 degrees of pipeline parallelism
    naturally, without having to think you are writing a parallel
    algorithm
- UNIX pipelines offer a time-tested way to write this kind of code
  - focus on the data: regexps, accumulators, projections, not the parallel framework
  - pipeline flow control has been optimized over decades
  - grep, awk, sed are extremely fast
  - lack of meta-stability: `a | b | c | d` versus `a | bc | d` is not
    the kind of optimization you need to worry about
  - anti-viral: you can mix and match operators written in… whatever
- then, a few impl details...
- then, a few numbers

## How it Works

![Architecture](super-architecture.png)

## How it Performs

![Performance Comparison](commoncrawl-comparo.png)

Importantly, our experiments show that this parallel efficiency is
possible, even after factoring in the latencies of fetching and
emitting data, and also the load imbalances across pipeline stages.

Furthermore, the solutions seem to be stable. When adding a fourth
stage `d`, one does not spend much thought on `a | b | cd` versus `a |
b | c | d`, because we know that operating systems manage processes
and FIFOs with aplomb. For example, unless trying to squeeze out a few
last percentage points, any performance differences `grep foo | grep
bar` versus `grep 'foo|bar'` are outweighed by the elegance of keeping
stages simple and orthogonal.

This core count is aligns nicely with current
price/performance sweet spots of Cloud offerings.

## Idea 1: Full Stream Ahead!

UNIX offers us a concise language for expressing streaming
computations. The utterance `cat in | a | b | c > out` expresses how
to acquire the data, where it should settle, and the stages of
analysis in-between.  These magic `|` and `>` operators take little
space on screen, and their cognitive load is low. We have faith that,
as long as those `a`, `b`, and `c` operators consume and produce
streams of bits, then the operating system will do us right.

To extend the approach to new data stores requires only adding new
interpretations for data ingress (what does it mean to `cat` an object
from your Cloud storage?) and egress (what does it mean to `>` to your
Cloud storage?).

As an example of the power of this "mix and match" approach to
composition, we compared using `awk` as a way to histogram a stream by
its first column to custom C++ code to do the same. The compiled and
gcc-optimized code was, even in the best case, only a few percent
faster.  If this were one-off code, certainly the effort expended to
write and maintain bespoke code would not outweigh the few percentage
points we got in return.

At the same time, this strategy gives us the option to contribute
generally beneficial hand-optimizations to the community. Others can
now replace their custom awk logic, and with minimal effort:
e.g. instead of `a | b | awk ...` it is now `a | b | histo`.
