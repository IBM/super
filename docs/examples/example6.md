# Super Power 6: Periodic Pipelines

<img src="images/runvis6.png" align="left" height="125">

To execute a pipeline periodically, use `super every`. This command
takes one additional positional parameter, the time period between
executions of the pipeline. When specifying your period, you may use
the conventional shorthands for time units. For example `super every
5m --- a | b | c` will execute that pipeline every five minutes; `4h`
denotes a four-hour period, and `1d` denotes a daily periodicity.

<br>

## Example

To generate a histogram of the CPU models running in your Cloud, every hour:

```sh
super every 60m -p3 -- `lscpu | grep "Model name" | cut -f2 -d ":"' | sort | uniq -c
```
## Other Super Powers

[<img src="images/runvis1.png" height="77">](example1.md)
[<img src="images/runvis2.png" height="77">](example2.md)
[<img src="images/runvis3.png" height="77">](example3.md)
[<img src="images/runvis4.png" height="77">](example4.md)
[<img src="images/runvis5.png" height="77">](example5.md)
