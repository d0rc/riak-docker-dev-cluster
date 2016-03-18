FROM centos:7

RUN curl -fo /etc/yum.repos.d/basho.repo \
         'https://packagecloud.io/install/repositories/basho/riak/config_file.repo?os=el&dist=7&name=docker' && \
    yum update -y && \
    yum install -y \
	bind-utils \
    	riak \
    	&& \
    yum clean all

COPY scripts/*.sh /

ENTRYPOINT ["sh", "/riak-run.sh"]
