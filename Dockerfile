FROM confluentinc/cp-kafkacat:6.0.0
USER root
RUN yum clean all
RUN yum install -y bind-utils openssl unzip findutils net-tools nc jq which
# aws clu
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
# ccloud clu
RUN wget https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_linux_amd64.tar.gz && tar -xzvf ccloud_latest_linux_amd64.tar.gz && mv ccloud/ccloud /usr/bin && rm ccloud_latest_linux_amd64.tar.gz
COPY include/etc/confluent/docker /etc/confluent/docker
# CP
# 1. Adding Confluent repository
RUN rpm --import https://packages.confluent.io/rpm/6.0/archive.key
COPY confluent.repo /etc/yum.repos.d/confluent.repo
# 2. Install confluent kafka tools:
RUN yum install -y confluent-platform

USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/etc/confluent/docker/run"]