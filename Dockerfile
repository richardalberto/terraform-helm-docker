FROM hashicorp/terraform:light

ENV TERRAFORM_HELM_PROVIDER_VERSION="v0.5.1"

RUN wget https://github.com/mcuadros/terraform-provider-helm/releases/download/${TERRAFORM_HELM_PROVIDER_VERSION}/terraform-provider-helm_${TERRAFORM_HELM_PROVIDER_VERSION}_linux_amd64.tar.gz \
  && tar -xvf terraform-provider-helm*.tar.gz \
  && mkdir -p /root/.terraform.d/plugins/linux_amd64/ \
  && mv terraform-provider-helm*/terraform-provider-helm /root/.terraform.d/plugins/linux_amd64/terraform-provider-helm_${TERRAFORM_HELM_PROVIDER_VERSION} \
  && chown root:root /root/.terraform.d/plugins/linux_amd64/terraform-provider-helm_${TERRAFORM_HELM_PROVIDER_VERSION} \
  && rm -rf terraform-provider-helm*
