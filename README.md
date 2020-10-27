<!-- omit in toc -->
# confluent-tools

![docker pulls](https://img.shields.io/docker/pulls/vdesabou/confluent-tools)

Docker image with various command lines and tools

<!-- omit in toc -->
## Table of Contents

- [AWI CLI](#awi-cli)
- [Confluent Cloud CLI (ccloud)](#confluent-cloud-cli-ccloud)

## AWI CLI

* Using credentials file:

```bash
$ docker run --rm -it -v $HOME/.aws:/home/appuser/.aws vdesabou/confluent-tools aws
```

* Using environment variables

This is supported, although NOT encouraged, as the environment variables can end up in command-line history, available for container inspection, etc.

```bash
$ docker run --rm -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY vdesabou/confluent-tools aws
```

## Confluent Cloud CLI (ccloud)

Authenticate by running:

```bash
$ docker run --rm -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" -v /home/ccloud/ --name ccloud-config vdesabou/confluent-tools ccloud login
```

Once you authenticate successfully, credentials are preserved in the volume of the ccloud-config container.

To run ccloud commands using these credentials, run the container with `--volumes-from ccloud-config`:

Example:

```bash
$ docker run --rm -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" --volumes-from ccloud-config vdesabou/confluent-tools ccloud kafka cluster list
```

:warning: Warning: The `ccloud-config` container now has a volume containing your Confluent Cloud credentials.

Once you're done, you can remove `ccloud-config` container:

```bash
$ docker rm -f ccloud-config
```
