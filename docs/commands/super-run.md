# The Super Commands: `super run`

**Super** allows you to specify a UNIX command line to execute *in
parallel* against a set of Cloud data.  Super takes care of
provisioning the right amount of compute, memory, and disk capacity,
scheduling your jobs, granting the needed data access authority to
your work, and streaming out logs --- all in one command: `super run`.

Super uses containers running in IBM Cloud [Code
Engine](https://www.ibm.com/cloud/code-engine) as the compute layer,
and gives your jobs access to data via IBM [Cloud Object
Storage](https://www.ibm.com/cloud/object-storage).

# Usage

```sh
super run Fires off the bash pipeline a | b | c as a cloud job

  To parallelize across a set of files, specify a file glob e.g. '*.txt' or 'file-{1,2,3}.txt'. Use 
  shell > syntax to capture output to cloud storage.

  Use 'single quotes' around pipelines to avoid local execution of | > $ etc.

Usage:
  super run [options] -- 'a | b | c'
  super run [options] -- 'a | b | c > /s3/ibm/default/myBucket'

Examples:
super run -p 5 -- pwd                to test your setup; you should see the pwd output / repeated 5 times
super run -p 20 -- 'echo $JOB_INDEX' the JOB_INDEX env. var. will be in the range 1..20 in this case     
super examples                       provides more detailed examples                                      

Options:
-f        Input file; use - for stdin                                                 
-i        Use a custom docker image default: starpit/sh:0.0.5                         
-p        Repeat a given pipeline N times default: number of glob matches             
-g        Emit more debugging output from the cloud-based jobs                        
-q        Emit only pipeline output, e.g. for piping into other tasks                 
--db      Pop up a window to track pipeline progress in a graphical dashboard         
--cpu, -m Cores and memory for each task default: cpu=1, memory=1024Mi                
--as      Execute the pipeline using the settings defined in the given `<profileName>`

Related:
  super logs, super show, super browse s3
```
