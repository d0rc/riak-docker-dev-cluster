#!/bin/sh

trap 'echo "SHUTTING DOWN"; riak stop ; exit $?' HUP INT QUIT KILL TERM

export IPADDR=`grep ${HOSTNAME} /etc/hosts|awk '{print $1}'`

cp /etc/riak/riak.conf{,.docker}
sed -i "s:riak@127.0.0.1:riak@${IPADDR}:" /etc/riak/riak.conf
sed -i "s:^log.console = file:log.console = both:" /etc/riak/riak.conf
echo "listener.http.external = ${IPADDR}:8098" >>/etc/riak/riak.conf
echo "listener.protobuf.external = ${IPADDR}:8087" >>/etc/riak/riak.conf
echo "riak_control = on" >> /etc/riak/riak.conf
riak start

echo "Sleeping before joining cluster"
nodes=`dig +short riak | sort`
for node in $nodes
do
	echo riak-admin cluster join riak@$node
done
sleep `expr 10 + ${RANDOM} % 10`
for node in $nodes
do
	riak-admin cluster join riak@$node
done

echo "Sleeping before committing to cluster"
sleep `expr 15 + ${RANDOM} % 15`
riak-admin cluster plan
riak-admin cluster commit

tail -F /var/log/riak/console.log
