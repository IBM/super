# Super Power 1: Running a Fixed Set of Jobs

<img src="images/runvis1.png" align="left" height="150">

The core command for scheduling a set of Cloud jobs is **`super
run`**.  Using the **`-p`** option to `super run`, Super can run a
fixed number of UNIX command lines, in the Cloud. The output of the
`N` jobs will be joined and flowed to `stdout`.

To help distinguish the output flowing from many concurrent jobs, the
log lines emitted by a job with job index `k` are prefixed by `[Job
k]`. 

- You may specify **`-q`** if you wish only to see the output of the
jobs. If you pipe the output of `super run` to other commands on your
laptop, Super will automatically operate in `-q` mode.
- You may also specify **`-g`** if you need to debug the output at a
finer level.
- Via the **`-f`** option, you may provide your pipeline as a file,
  and via `-f -` you may do so via `stdin`.

## Example

```sh
super run -p3 -- printenv JOB_INDEX
[Job 1] 1
[Job 2] 2
[Job 3] 3
```

Here we specified `-p3`, and printed out a convenience environment
variable `JOB_INDEX` inside of each Cloud job. The output flows to our
terminal.

## Other Super Powers

<!--[<img src="images/runvis1.png" height="77">](example1.md)-->
[<img src="images/runvis2.png" height="77">](example2.md)
[<img src="images/runvis3.png" height="77">](example3.md)
[<img src="images/runvis4.png" height="77">](example4.md)
[<img src="images/runvis5.png" height="77">](example5.md)
