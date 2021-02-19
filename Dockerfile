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

ENV DENO_VERSION=1.7.4 \
    # Set paths to avoid hard-coding them in scripts.
    APP_DATA=/opt/app-root/src \
    # Incantations to enable Software Collections on `bash` and `sh -i`.
    BASH_ENV="\${CONTAINER_SCRIPTS_PATH}/scl_enable" \
    ENV="\${CONTAINER_SCRIPTS_PATH}/scl_enable" \
    PROMPT_COMMAND=". \${CONTAINER_SCRIPTS_PATH}/scl_enable"

RUN curl -fsSL https://deno.land/x/install/install.sh | sh

#Manually add the directory to your $HOME/.bash_profile (or similar)
Run export DENO_INSTALL="/.deno/bin/deno" && \
    export PATH="$DENO_INSTALL/bin:$PATH" && \
    '/.deno/bin/deno --help'

# Since $HOME is set to /opt/app-root where deno is installed. The deno directory will be owned by root and can
# cause actions that work on all of /opt/app-root to fail. So we need to fix
# the permissions on those too.
RUN chown -R 1001:0 /opt/app-root && fix-permissions /opt/app-root

# trying to add deno directory to the PATH
#ENV PATH="/opt/app-root/src/.deno/bin/deno:$PATH"


#TESTING
#print the working directory
RUN pwd
RUN printenv

CMD deno run https://deno.land/std/examples/welcome.ts

# Run container by default as user with id 1001 (default)
USER 1001
# ENTRYPOINT ["deno"]
# CMD ["run", "https://deno.land/std/examples/welcome.ts"]
#RUN deno run https://deno.land/std/examples/welcome.ts
