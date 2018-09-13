FROM hashicorp/terraform:full

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.10.0"

# Note: Latest version of the provider may be found at:
# https://mcuadros/terraform-provider-helm/releases
ENV HELM_PROVIDER_VERSION="0.6.0"

RUN apk add make gcc linux-headers musl-dev --no-cache --virtual /tmp/.build-deps

RUN mkdir -p $GOPATH/src/github.com/mcuadros \
  && git clone https://github.com/mcuadros/terraform-provider-helm.git $GOPATH/src/github.com/mcuadros/terraform-provider-helm \
  && cd $GOPATH/src/github.com/mcuadros/terraform-provider-helm \
  && git fetch --all --tags --prune \
  && git checkout tags/v${HELM_PROVIDER_VERSION} \
  && make build \
  && mkdir -p ~/.terraform.d/plugins/ \
  && mv $GOPATH/src/github.com/mcuadros/terraform-provider-helm/terraform-provider-helm ~/.terraform.d/plugins/ \
  && rm -rf $GOPATH/src

RUN wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN apk del /tmp/.build-deps