# Super Example 5: Injecting Cloud Binaries

<img src="images/runvis5.png" align="left" height="125">

You may also inject custom scripts into the running jobs. You may use
any Cloud bucket to store your binaries.

<br>
<br>

## Example

Here, we use the convenience path `/s3/ibm/bin` that Super
provides. Just for fun, we use a [here
document](https://tldp.org/LDP/abs/html/here-docs.html), via `cat
<<EOF` and the `-f -` option to `super run`, to provide the pipeline
to be run.

```sh
super mkdir /s3/ibm/tmp/dst
super cp myAnalysis.sh /s3/ibm/bin

cat <<EOF | super run -f -
gunzip -c /s3/ibm/tmp/*.gz | /s3/ibm/bin/myAnalysis.sh > /s3/ibm/tmp/dst/out-$j.txt
EOF
```

## Other Super Powers

[<img src="images/runvis1.png" height="75">](example1.md)
[<img src="images/runvis2.png" height="75">](example2.md)
[<img src="images/runvis3.png" height="75">](example3.md)
[<img src="images/runvis4.png" height="75">](example4.md)
[<img src="images/runvis6.png" height="75">](example6.md)
