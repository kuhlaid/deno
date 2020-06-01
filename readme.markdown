# DenoJS on Alpine

Simple dockerfile to create an alpine-based deno container. It's based on the alpine-gcc build from frolvlad/alpine-glibc.

## Usage

Just do a `docker-run --rm lsmoura/deno` and you should get a welcome message! 

If you want to run any js/ts file that resides on your current folder, you can do so like this: `docker run --rm -v $(pwd):/app lsmoura/deno run somefile.ts`.

Lastly, if you want to create your own self-container application that resides on the current folder, you can use this as a base image, and a Dockerfile like so:

```
FROM lsmoura/deno:1.0.3

COPY . ./

CMD ["run", "./somefile.ts"]
```
