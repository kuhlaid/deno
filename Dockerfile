FROM registry.access.redhat.com/rhscl/s2i-core-rhel7:1

ENV SUMMARY="DenoJs server" \
    DESCRIPTION="DenoJs (a better NodeJs) is a free and open-source \
    javascript runtime. This container image builds a DenoJs server."
    
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

RUN curl -fsSL https://deno.land/x/install/install.sh | sh

ENV DENO_DIR /opt/app-root/src/.deno/bin/deno

# RUN addgroup -g 1993 -S deno \
#  && adduser -u 1993 -S deno -G deno \
#  && mkdir ${DENO_DIR} \
#  && chown deno:deno ${DENO_DIR}


# WORKDIR ${DENO_DIR}

# ENTRYPOINT ["deno"]
RUN ${DENO_DIR} && deno run https://deno.land/std/examples/welcome.ts
