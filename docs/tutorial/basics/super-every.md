### Table Of Contents

- [Running UNIX Commands in the Cloud](./README.md#readme)
- [Interacting with Cloud Object Storage](./super-cos.md#readme)
- [Visually Browsing Cloud Object Storage](./super-browse.md#readme)
- [Parallelizing your UNIX Pipeline](./super-parallelism.md#readme)
- [Injecting Custom Binaries](./super-cloudbin.md#readme)
- [Examples of parallel analytics against CommonCrawl data](../../blogs/2-Super-CommonCrawl#readme)
- [Automating Periodic Tasks](./super-every.md#readme) **[You are here]**

# Automating Periodic Tasks with `super every`

You may execute a given pipeline periodically with the help of the
`super every` command. This command has mostly the same structure as
`super run`, but will execute the given pipeline according to a
specified schedule, rather than once. For example to execute a
pipeline every 30 minutes:

```sh
super every 30m --as <profileName> -- gunzip /s3/ibm/default/inputData/*.gz | analyze.py > /s3/ibm/default/outputData
```

The `--as` option allows you to choose a set of configuration options
under which to run the task. For example, you may want to automate one
task against CodeEngine `projectA` and another against `projectB`. See
[below](#profiles-as-a-way-to-specify-configuration-options) for more
detail on these configuration *profiles*.

You may then list your active periodic tasks via

```sh
super get every
```

And may see the low-level details of a specified periodic task via

```sh
super get every <taskName> -o yaml
```

## Profiles as a way to Specify Configuration Options

Generally speaking, an automated task needs to run against a
particular instance of Cloud Object Storage, e.g. so that `>
/s3/ibm/default/...` redirects the output of your automated pipelines
to the right place.

Which means that when automating a pipeline, you need to express a set
of choices. 

```sh
super create profile <profileName> \
  --apikey <ibmcloud apikey> \
  --cos-instance <Cloud Object Storage instance name> \
  [--code-engine-project <CodeEngine project name>] \
  [--region <ibmcloud region>] \
  [--resource-group <ibmcloud resource group>] \
```

You may then list your profiles via

```sh
super get profile
```

And you may see the details of a specified profile via

```sh
super get profile <profileName> -o <yaml|json>
```

And may delete a specified profile via

```sh
super delete profile <profileName>
```
