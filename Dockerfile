FROM hashicorp/terraform:light

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.10.0"

# Note: Latest version of the provider may be found at:
# https://mcuadros/terraform-provider-helm/releases
ENV HELM_PROVIDER_VERSION="0.6.0"

RUN apk add curl wget --no-cache --virtual /tmp/.build-deps

RUN curl -Ls -o terraform-provider-helm.tar.gz https://github.com/mcuadros/terraform-provider-helm/releases/download/v${HELM_PROVIDER_VERSION}/terraform-provider-helm_v${HELM_PROVIDER_VERSION}_linux_amd64.tar.gz \
    && tar -xzvf terraform-provider-helm.tar.gz \
    && mkdir -p ~/.terraform.d/plugins/ \
    && mv terraform-provider-helm*/terraform-provider-helm ~/.terraform.d/plugins/

RUN wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN apk del /tmp/.build-deps