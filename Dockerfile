FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.15-openshift-4.8 AS builder

# do something similar??
#RUN mv /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /usr/glibc-compat/lib/ld-linux-x86-64.so \
#  && ln -s ld-linux-x86-64.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2
    
LABEL maintainer="w. Patrick Gale <w.patrick.gale@unc.edu>"

ARG DENO_VERSION
ENV DENO_VERSION ${DENO_VERSION:-v1.7.4}

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
