FROM ubuntu:16.04

LABEL maintainer "jmaelstrom@gmail.com"

ENV ANSIBLE_HOST_KEY_CHECKING "False"

RUN apt-get update \
&& apt-get install -y software-properties-common \
&& apt-add-repository -y ppa:ansible/ansible \
&& apt-get update \
&& apt-get install -y ansible \
&& rm -rf /var/lib/apt/lists/*

VOLUME /tmp/hostssh

COPY entrypoint.sh /opt/

RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
