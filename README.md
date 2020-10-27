<!-- omit in toc -->
# confluent-tools

![docker pulls](https://img.shields.io/docker/pulls/vdesabou/confluent-tools)

Docker image with various command lines and tools

<!-- omit in toc -->
## Table of Contents

- [AWS CLI (aws)](#aws-cli-aws)
- [Azure CLI (az)](#azure-cli-az)
- [Google Cloud CLI (gcloud)](#google-cloud-cli-gcloud)
- [Confluent Cloud CLI (ccloud)](#confluent-cloud-cli-ccloud)

## AWS CLI (aws)

* Using credentials file:

```bash
$ docker run --rm -it -v $HOME/.aws:/home/appuser/.aws vdesabou/confluent-tools aws
```

* Using environment variables

This is supported, although NOT encouraged, as the environment variables can end up in command-line history, available for container inspection, etc.

```bash
$ docker run --rm -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY vdesabou/confluent-tools aws
```

## Azure CLI (az)


Authenticate by running:

```bash
$ docker run -ti -v /home/appuser/ --name confluent-tools-azure-config vdesabou/confluent-tools az login
```

Once you authenticate successfully, credentials are preserved in the volume of the confluent-tools-azure-config container.

To run ccloud commands using these credentials, run the container with `--volumes-from confluent-tools-azure-config`:

Example:

```bash
$ docker run --rm -ti --volumes-from confluent-tools-azure-config vdesabou/confluent-tools az group list
```

:warning: Warning: The `confluent-tools-azure-config` container now has a volume containing your Confluent Cloud credentials.

Once you're done, you can remove `confluent-tools-azure-config` container:

```bash
$ docker rm -f confluent-tools-azure-config
```

## Google Cloud CLI (gcloud)


Authenticate by running:

```bash
$ docker run -ti -v /home/appuser/ --name confluent-tools-gcloud-config vdesabou/confluent-tools gcloud auth login
```

Once you authenticate successfully, credentials are preserved in the volume of the confluent-tools-gcloud-config container.

To run ccloud commands using these credentials, run the container with `--volumes-from confluent-tools-gcloud-config`:

Example:

```bash
$ docker run --rm -ti --volumes-from confluent-tools-gcloud-config vdesabou/confluent-tools gcloud config set project PROJECT_ID
```

:warning: Warning: The `confluent-tools-gcloud-config` container now has a volume containing your Confluent Cloud credentials.

Once you're done, you can remove `confluent-tools-gcloud-config` container:

```bash
$ docker rm -f confluent-tools-gcloud-config
```


## Confluent Cloud CLI (ccloud)

Authenticate by running:

```bash
$ docker run -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" -v /home/appuser/ --name confluent-tools-ccloud-config vdesabou/confluent-tools ccloud login
```

Once you authenticate successfully, credentials are preserved in the volume of the confluent-tools-ccloud-config container.

To run ccloud commands using these credentials, run the container with `--volumes-from confluent-tools-ccloud-config`:

Example:

```bash
$ docker run --rm -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" --volumes-from confluent-tools-ccloud-config vdesabou/confluent-tools ccloud kafka cluster list
```

:warning: Warning: The `confluent-tools-ccloud-config` container now has a volume containing your Confluent Cloud credentials.

Once you're done, you can remove `confluent-tools-ccloud-config` container:

```bash
$ docker rm -f confluent-tools-ccloud-config
```
