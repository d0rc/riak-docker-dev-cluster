
From Homebrew, install:

 * brew install xhyve docker docker-machine docker-machine-driver-xhyve

docker-machine's xhyve driver needs to run as root:

 * sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
 * sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

Set up virtual machine to run docker containers:

 * docker-machine create --driver xhyve default

Set the environment:

 * eval $(docker-machine env)

Start Riak cluster:

 * make start

Stop Riak cluster:

 * make stop
