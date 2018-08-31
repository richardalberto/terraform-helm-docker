# terraform-helm-docker
Docker image with the [terraform-helm](https://github.com/mcuadros/terraform-provider-helm) provider pre-installed

## Pull
`
docker pull richardalberto/terraform-helm-docker
`

## Usage
```
docker run -it richardalberto/terraform-helm-docker init
docker run -it richardalberto/terraform-helm-docker plan
docker run -it richardalberto/terraform-helm-docker apply
```
