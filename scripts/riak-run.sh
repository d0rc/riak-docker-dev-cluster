#!/bin/sh

trap 'echo "SHUTTING DOWN"; riak stop ; exit $?' HUP INT QUIT KILL TERM

export IPADDR=`grep ${HOSTNAME} /etc/hosts|awk '{print $1}'`

cp /etc/riak/riak.conf{,.docker}
sed -i "s:riak@127.0.0.1:riak@${IPADDR}:" /etc/riak/riak.conf
sed -i "s:^log.console = file:log.console = both:" /etc/riak/riak.conf
echo "listener.http.external = ${IPADDR}:8098" >>/etc/riak/riak.conf
echo "listener.protobuf.external = ${IPADDR}:8087" >>/etc/riak/riak.conf

# Sleep so First node and other nodes don't start on same second
if [ -n "${FIRST}" ]; then
    echo "Sleeping before starting Riak"
    sleep `expr ${RANDOM} % 10`
fi

riak start

# If not First node, sleep and then join the cluster
if [ -n "${FIRST}" ]; then
    echo "Sleeping before joining cluster"
    sleep `expr ${RANDOM} % 60`
    riak-admin cluster join riak@`dig +short ${FIRST}`
    riak-admin cluster plan
    riak-admin cluster commit
fi

tail -F /var/log/riak/console.log
