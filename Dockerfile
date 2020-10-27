FROM confluentinc/cp-kafkacat:6.0.0
USER root
RUN yum clean all
# add google and azure repo config
COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo
COPY azure-cli.repo /etc/yum.repos.d/azure-cli.repo
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
# get proxychains
RUN wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/proxychains-ng-4.11-1.sdl7.x86_64.rpm
# install utils
RUN yum install -y bind-utils openssl unzip findutils net-tools nc jq which testssl hping3 proxychains-ng-4.11-1.sdl7.x86_64.rpm azure-cli google-cloud-sdk
# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm awscliv2.zip
# ccloud cli
RUN wget https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_linux_amd64.tar.gz && tar -xzvf ccloud_latest_linux_amd64.tar.gz && mv ccloud/ccloud /usr/bin && rm ccloud_latest_linux_amd64.tar.gz
COPY include/etc/confluent/docker /etc/confluent/docker
# CP
# 1. Adding Confluent repository
RUN rpm --import https://packages.confluent.io/rpm/6.0/archive.key
COPY confluent.repo /etc/yum.repos.d/confluent.repo
# 2. Install confluent kafka tools:
RUN yum install -y confluent-platform
# Confluent CLI
RUN curl -L https://cnfl.io/cli | sh -s -- -b /usr/local/bin/

USER appuser
WORKDIR /home/appuser
ENTRYPOINT ["/etc/confluent/docker/run"]
