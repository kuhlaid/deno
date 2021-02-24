# DenoJS in RHEL OpenShift

The Dockerfile in this repo is used to create a CentOS image for use in RedHat OpenShift.

## Usage

I use Docker Hub to build and host the image (https://hub.docker.com/repository/docker/fowrfkmjnn9fro/openshift-deno). You can fork this repo and build you own version of the image on Docker Hub so OpenShift can access it. For initial testing you can simply log into OpenShift and use the Deploy Image option to add the 'fowrfkmjnn9fro/openshift-deno' image (since OpenShift knows to look in Docker Hub for this image). After you have the image deployed in OpenShift you will need to go into the new Service for this image and Create a Route so the Deno HelloWorld example can be accessed via an HTTP address.
