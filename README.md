# confluent-tools

Docker image with various command lines and tools





## Using Confluent Cloud CLI (ccloud)

Authenticate by running:

```bash
$ docker run -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" -v /home/ccloud/ --name ccloud-config vdesabou/confluent-tools ccloud login
```

Once you authenticate successfully, credentials are preserved in the volume of the ccloud-config container.

To run ccloud commands using these credentials, run the container with `--volumes-from ccloud-config`:

Exemple:

```bash
$ docker run -ti -e "CCLOUD_BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS" -e "CCLOUD_API_KEY=$CCLOUD_API_KEY" -e "CCLOUD_API_SECRET=$CCLOUD_API_SECRET" --volumes-from ccloud-config vdesabou/confluent-tools ccloud kafka cluster list
```

:warning: Warning: The `ccloud-config` container now has a volume containing your Confluent Cloud credentials.

Once you're done, you can remove `ccloud-config` container:

```bash
$ docker rm -f ccloud-config
```
