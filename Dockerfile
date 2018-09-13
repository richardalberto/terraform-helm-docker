FROM hashicorp/terraform:light

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.10.0"

# Note: Latest version of the provider may be found at:
# https://mcuadros/terraform-provider-helm/releases
ENV HELM_PROVIDER_VERSION="0.6.0"

ENV PLUGINS_FOLDER="/root/.terraform.d/plugins/"

RUN apk add curl wget --no-cache --virtual /tmp/.build-deps

# The helm provider binary was compiled with glibc and on Alpine that is not 
# installed by default. Since the musl and glibc so are compatible we need to create this symlink. 
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN curl -Ls -o terraform-provider-helm.tar.gz https://github.com/mcuadros/terraform-provider-helm/releases/download/v${HELM_PROVIDER_VERSION}/terraform-provider-helm_v${HELM_PROVIDER_VERSION}_linux_amd64.tar.gz \
    && tar -xzvf terraform-provider-helm.tar.gz \
    && mkdir -p $PLUGINS_FOLDER \
    && mv terraform-provider-helm*/terraform-provider-helm $PLUGINS_FOLDER/terraform-provider-helm \
    && rm -rf terraform-provider-helm.tar.gz terraform-provider-helm*

RUN wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN apk del /tmp/.build-deps