FROM confluentinc/cp-kafkacat:6.0.0
USER root
RUN yum clean all
RUN yum install -y bind-utils openssl unzip findutils net-tools nc jq
# aws clu
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
# ccloud clu
RUN wget https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_linux_amd64.tar.gz && tar -xzvf ccloud_latest_linux_amd64.tar.gz && mv ccloud/ccloud /usr/bin
COPY include/etc/confluent/docker /etc/confluent/docker

USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/etc/confluent/docker/run"]