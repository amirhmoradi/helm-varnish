# helm-varnish
Helm Chart for Varnish

# Using in Kubernetes

This image can be used in Kubernetes via helm to provide a varnish (proxy) service. View [helm-varnish](https://github.com/amirhmoradi/helm-varnish) for more information.

# Varnish

[Varnish Cache](https://varnish-cache.org/) is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture. A high level overview of what Varnish does can be seen in [this video](https://www.youtube.com/watch?v=fGD14ChpcL4).

## TL;DR;

```console
$ helm install https://github.com/amirhmoradi/helm-varnish/archive/latest.tar.gz
```

## Introduction

This chart bootstraps a [Varnish](https://github.com/tripviss/docker-varnish) service on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release https://github.com/amirhmoradi/helm-varnish/archive/latest.tar.gz
```

The command deploys Varnish on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the varnish chart and their default values.

|             Parameter              |               Description                |                         Default                          |
|------------------------------------|------------------------------------------|----------------------------------------------------------|
| `image.registry`                   | Varnish image registry                   | `docker.io`                                              |
| `image.repository`                 | Varnish Image name                       | `tripviss/varnish`                                       |
| `image.tag`                        | Varnish Image tag                        | `{VERSION}`                                              |
| `image.pullPolicy`                 | Image pull policy                        | `Always` if `imageTag` is `latest`, else `IfNotPresent`  |
| `image.pullSecrets`                | Specify image pull secrets               | `nil`                                                    |
| `varnishPort`                      | Varnish Port                             | `6081`                                                   |
| `varnishDaemonOptions`             | Varnish Daemon Options                   | `nil`                                                    |
| `varnishLoadBalancerIP`            | `loadBalancerIP` for the varnish Service | `nil`                                                    |
| `serviceType`                      | Kubernetes Service type                  | `LoadBalancer`                                           |
| `resources`                        | CPU/Memory resource requests/limits      | Memory: `512Mi`, CPU: `300m`                             |

The above parameters map to the env variables defined in [bitnami/varnish](http://github.com/bitnami/bitnami-docker-varnish). For more information please refer to the [bitnami/varnish](http://github.com/bitnami/bitnami-docker-varnish) image documentation.

> **Note**:
>
> For this helm to function correctly, you should specify the `varnishHost` parameter to specify the FQDN (recommended) or the public IP address of the varnish service.
>
> Optionally, you can specify the `varnishLoadBalancerIP` parameter to assign a reserved IP address to the varnish service of the chart. However please note that this feature is only available on a few cloud providers (f.e. GKE).
>
> To reserve a public IP address on GKE:
>
> ```bash
> $ gcloud compute addresses create varnish-public-ip
> ```
>
> The reserved IP address can be associated to the varnish service by specifying it as the value of the `varnishLoadBalancerIP` parameter while installing the chart.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set varnishUsername=admin,varnishPassword=password,mariadb.mariadbRootPassword=secretpassword \
    stable/varnish
```

The above command sets the varnish administrator account username and password to `admin` and `password` respectively. Additionally, it sets the MariaDB `root` user password to `secretpassword`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml stable/varnish
```

> **Tip**: You can use the default [values.yaml](values.yaml)
