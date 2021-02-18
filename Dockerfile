FROM rhscl/s2i-core-rhel7

ENV SUMMARY="DenoJs server" \
    DESCRIPTION="DenoJs (a better NodeJs) is a free and open-source \
    javascript runtime. This container image builds a DenoJs server."

# do something similar??
#RUN mv /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /usr/glibc-compat/lib/ld-linux-x86-64.so \
#  && ln -s ld-linux-x86-64.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2
    
LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="DenoJs 1.7.4" \
      io.openshift.tags="javascript" \
      com.redhat.component="rh-deno174-container" \
      name="kuhlaid/openshift-deno" \
      usage="deno run https://deno.land/std/examples/welcome.ts" \
      version="0.1" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
      maintainer="w. Patrick Gale <w.patrick.gale@unc.edu>"

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
