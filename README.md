
From Homebrew, install:

```console
$ brew install xhyve docker docker-machine docker-machine-driver-xhyve
```

docker-machine's xhyve driver needs to run as root:

```console
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

Set up virtual machine to run docker containers:

```console
$ docker-machine create --driver xhyve default
```

Set the environment:

```console
$ eval $(docker-machine env)
```

Start Riak cluster:

```console
$ make start
```

Stop Riak cluster:

```console
$ make stop
```
