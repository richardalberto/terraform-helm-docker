FROM hashicorp/terraform:full

ENV HELM_PROVIDER_VERSION="0.5.1"

RUN apk add make gcc linux-headers musl-dev --no-cache

RUN mkdir -p $GOPATH/src/github.com/mcuadros \
  && git clone https://github.com/mcuadros/terraform-provider-helm.git $GOPATH/src/github.com/mcuadros/terraform-provider-helm \
  && cd $GOPATH/src/github.com/mcuadros/terraform-provider-helm \
  && git fetch --all --tags --prune \
  && git checkout tags/v${HELM_PROVIDER_VERSION} \
  && make build

RUN mkdir -p ~/.terraform.d/plugins/ \
  && mv $GOPATH/src/github.com/mcuadros/terraform-provider-helm/terraform-provider-helm ~/.terraform.d/plugins/ \
  && rm -rf $GOPATH/src/github.com/mcuadros
