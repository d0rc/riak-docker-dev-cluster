
FROM centos:7
MAINTAINER Ossi Herrala <oherrala@gmail.com>

RUN curl "https://packagecloud.io/install/repositories/basho/riak/config_file.repo?os=el&dist=7&name=docker" >/etc/yum.repos.d/basho.repo && \
    yum update -y && \
    yum install -y \
	bind-utils \
    	riak \
    	&& \
    yum clean all

#        .- Riak / Erlang epmd listener
#       /              .- Riak Node handoff_port
EXPOSE 4369 8087 8098 8099
#            \    '- Riak client HTTP port
#             '- Riak client Protobuf port

COPY scripts/riak-run.sh /
COPY scripts/setup-debug.sh /

ENTRYPOINT ["sh", "/riak-run.sh"]
