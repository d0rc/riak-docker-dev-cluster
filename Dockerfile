FROM centos:7

RUN curl 'https://packagecloud.io/install/repositories/basho/riak/config_file.repo?os=el&dist=7&name=docker' >/etc/yum.repos.d/basho.repo && \
    yum update -y && \
    yum install -y \
	bind-utils \
    	riak \
    	&& \
    yum clean all

EXPOSE 8087 8098
#       \    '- Riak client HTTP port
#        '- Riak client Protobuf port

COPY scripts/*.sh /

ENTRYPOINT ["sh", "/riak-run.sh"]
