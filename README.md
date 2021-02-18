# DenoJS in RHEL OpenShift

Simple dockerfile to create an RHEL-based deno container. It's based on lsmoura/deno.

## Usage

Just do a `docker-run --rm kuhlaid/openshift-deno` and you should get a welcome message! 

If you want to run any js/ts file that resides on your current folder, you can do so like this: `docker run --rm -v $(pwd):/app kuhlaid/openshift-deno run myfile.ts`.

Lastly, if you want to create your own self-container application that resides on the current folder, you can use this as a base image, and a Dockerfile like so:

```
FROM kuhlaid/openshift-deno:1.7.4

COPY . ./

CMD ["run", "./somefile.ts"]
```
