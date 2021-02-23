FROM centos:8

ENV DENO_VERSION=1.7.2

RUN yum makecache \
 && yum install unzip -y \
 && curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 755 deno \
 && mv deno /bin/deno \
 && yum remove unzip -y \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN groupadd -g 1993 deno \
 && adduser -u 1993 -g deno deno \
 && mkdir /deno-dir/ \
 && chown deno:deno /deno-dir/

ENV DENO_DIR /deno-dir/
ENV DENO_INSTALL_ROOT /usr/local

COPY ./_entry.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["run", "https://deno.land/std/examples/welcome.ts"]



# # docker login registry.redhat.io
# # RUN login registry.redhat.io
# # Username: {REGISTRY-SERVICE-ACCOUNT-USERNAME}
# # Password: {REGISTRY-SERVICE-ACCOUNT-PASSWORD}

# RUN login registry.redhat.io --username XXXXXXXX --password XXXXXXXXXX
# # assumes pulling from registry.redhat.io/
# FROM rhel8/s2i-core:1

# # ----------- test (this ran but added 500Mb to the size and 
# # RUN yum upgrade -y \
# #     && yum install -y git gcc \
# #     && yum clean packages

# # RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
# # WORKDIR /tmp
# # CMD git clone --recurse-submodules https://github.com/denoland/deno.git \
# #     && cd deno \
# #     && . ~/.cargo/env \
# #     && cargo build --release \
# #     && mv target/release/deno /output
#  # ----------- test
 
 
# ENV SUMMARY="DenoJs server" \
#     DESCRIPTION="DenoJs (a better NodeJs) is a free and open-source \
#     javascript runtime. This container image builds a DenoJs server."
    
# LABEL summary="$SUMMARY" \
#       description="$DESCRIPTION" \
#       io.k8s.description="$DESCRIPTION" \
#       io.k8s.display-name="DenoJs 1.7.4" \
#       io.openshift.tags="javascript" \
#       com.redhat.component="rh-deno174-container" \
#       name="kuhlaid/openshift-deno" \
#       usage="deno run https://deno.land/std/examples/welcome.ts" \
#       version="0.1" \
#       com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
#       maintainer="w. Patrick Gale <w.patrick.gale@unc.edu>"

# ENV DENO_VERSION=1.7.4 \
#     # Set paths to avoid hard-coding them in scripts.
#     #APP_DATA=/opt/app-root/src \
#     PATH=/opt/app-root/src/.deno/bin:$PATH

# RUN curl -fsSL https://deno.land/x/install/install.sh | sh
    
# # Since $HOME is set to /opt/app-root where deno is installed. The deno directory will be owned by root and can
# # cause actions that work on all of /opt/app-root to fail. So we need to fix
# # the permissions on those too.
# RUN chown -R 1001:0 /opt/app-root && fix-permissions /opt/app-root

# ENV DENO_DIR=/opt/app-root/src/.deno/bin
    
# # TESTING
# RUN echo "----- need to print deno directory contents ----"
# RUN ls -la /opt/app-root/src/.deno/bin
# #RUN ls -la /opt/app-root/src/.deno/bin/deno
# RUN echo "----- end printing deno directory contents ----"

# #TESTING
# #print the working directory
# #RUN pwd
# RUN printenv

# #WORKDIR ${DENO_DIR}

# ENTRYPOINT ["deno"]
# CMD ["run", "https://deno.land/std/examples/welcome.ts"]

# # Run container by default as user with id 1001 (default)
# USER 1001
