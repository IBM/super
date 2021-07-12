# Super Power 1: Running a Fixed Set of Jobs

<img src="images/runvis1.png" align="left" height="150">

The core command for scheduling a set of Cloud jobs is **`super
run`**.  Using the **`-p`** option to `super run`, Super can run a
fixed number of UNIX command lines, in the Cloud. The output of the
`N` jobs will be joined and flowed to `stdout`.

<br>
<br>

## Example

```sh
super run -p3 -- printenv JOB_INDEX
[Job 1] 1
[Job 2] 2
[Job 3] 3
```

Here we specified `-p3`, and printed out a convenience environment
variable `JOB_INDEX` inside of each Cloud job. The output flows to our
terminal. To help distinguish the output flowing from many concurrent
jobs, the log lines emitted by a job with job index `k` are prefixed
by `[Job k]`.

## Options for `super run`

- **`-p`**: Use a fixed number of jobs.
- **`-q`**: Do not show the `[Job k]` prefix. If you pipe the output
of `super run` to other commands on your laptop, Super will
automatically operate in `-q` mode.
- **`-g`**: Add extra debugging information to the output of `super
  run`.
- **`-f`**: You may provide your pipeline as a file, and via `-f -`
  you may do so via `stdin`.
- **`-i`**: Specify a custom base Docker image. It is recommended that
  you extend `starpit/sh:0.0.5`.
- **`-c`**, **`-m`**: Specify a combination of CPU and memory
  allocation requests. Only [certain
  combinations](https://cloud.ibm.com/docs/codeengine?topic=codeengine-mem-cpu-combo)
  are supported.

## Other Super Powers

[<img src="images/runvis2.png" height="66">](example2.md)
[<img src="images/runvis3.png" height="66">](example3.md)
[<img src="images/runvis4.png" height="66">](example4.md)
[<img src="images/runvis5.png" height="66">](example5.md)
[<img src="images/runvis6.png" height="66">](example6.md)
