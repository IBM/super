# Super/Bash Web Server Classification

All implementations read in a local compressed WAT file.

- [**plainbash1**](plainbash1.sh) Uses jq for projection (inefficient)
- [**plainbash2**](plainbash2.sh) Uses grep for projection
- [**plainbash3**](plainbash3.sh) Uses awk for projection

## Usage

```sh
../init.sh
./run.sh ./plainbash1.sh
```
