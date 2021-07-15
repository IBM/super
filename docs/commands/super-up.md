# Using `super up` to validate your setup

Currently, `super run` has a set of prerequisites on your Cloud
configuration. The `super up` command can check these for you:

<img title="The super up command helps you with prerequisites" alt="The super up command helps you with prerequisites" src="super-up.gif" align="right" width="400">

```sh
super up

Checking prerequisites for the Super Laptop...
  ✓ CLI: kubectl
  ✓ CLI: ibmcloud
  ✓ CLI: ibmcloud login
  ✓ CLI plugin: ibmcloud code-engine
  ✓ CLI plugin: ibmcloud cloud-object-storage
  ✓ Cloud: ibmcloud target
  ✓ Cloud: CodeEngine project selected
  ✓ S3: mounted AWS
  ✓ S3: ibmcloud object storage credentials
  ✓ S3: mounted ibmcloud default region

🚀 You are all set to bash the cloud!
```

## Using `super up --fix` to fix issues

If some of the prerequisites are not satisfied, Super has a `--fix`
capability. This is still alpha, but is not destructive (it only adds,
such as creating credentials for access to your Cloud Object
Storage).

The most common situations are that you have not targeted an IBM Cloud
resource group, or that you do not have an HMAC credential for your
Cloud Object Storage instance. The `super up --fix` command can take
care of both:

```sh
super up --fix
```

## Specifying Compute and Storage Options

When auto-fixing your configuration, Super attempts to make some
intelligent default choices. For example, if you have only a single
way to schedule jobs (e.g. you have access to a single IBM CodeEngine
project), it will assume that choice, without prompt.

### Additional Profile Options

You may override these default choices with the following additional
options for `super up`, which allow you to create your own custom
"profile":

- `--sso`: Log on to IBM Cloud using the Single Sign-On method
- `--apikey <key>`: Log on to IBM Cloud using the apikey method, with the given key
- `--resource-group <name>`: Target the specified Cloud resource group
- `--region <name>`: Target the specified Cloud region
- `--cos-instance <name>`: Use the specified Cloud Object Storage instance for `/s3/ibm/default`
- `--code-engine-project <name>`: Use the named project

> **Current Limitations**: `super up --fix` does not automatically
create a Cloud Object Storage instance. Please ensure that you have a
Cloud Object Storage instance. Thanks!

> **Alpha Warning**: It is also likely to have some corner cases that
have fallen through the cracks. If so, please let us know! We think
this auto-onboarding capability is critical to a compelling story, so
appreciate your help.

