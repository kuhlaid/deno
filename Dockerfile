FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31
LABEL maintainer="Sergio Moura <sergio@moura.ca>"

RUN mv /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /usr/glibc-compat/lib/ld-linux-x86-64.so \
  && ln -s ld-linux-x86-64.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2

ARG DENO_VERSION
ENV DENO_VERSION ${DENO_VERSION:-v1.0.3}

RUN apk add --virtual .download --no-cache curl \
 && curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 755 deno \
 && mv deno /bin/deno \
 && apk del .download

ENV DENO_DIR /app/

RUN addgroup -g 1993 -S deno \
 && adduser -u 1993 -S deno -G deno \
 && mkdir ${DENO_DIR} \
 && chown deno:deno ${DENO_DIR}


WORKDIR ${DENO_DIR}

ENTRYPOINT ["deno"]
CMD ["run", "https://deno.land/std/examples/welcome.ts"]
