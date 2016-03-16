## Get Ready!

### Option 1: Homebrew & xhyve

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

### Option 2: Docker Toolbox & VirtualBox

Install [Docker Toolbox](https://www.docker.com/docker-toolbox), which sets up Docker, Docker Machine, Docker Compose and VirtualBox (among other things).

Create the Docker Machine VM ```default``` with the VirtualBox driver. You can use the ```--virtualbox-no-share``` option, telling ```docker-machine``` *not* to share your whole ```/Users``` directory inside the created VM.

```console
$ docker-machine create --driver virtualbox --virtualbox-no-share
```

## And Go!

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
