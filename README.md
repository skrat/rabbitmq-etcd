RabbitMQ docker image / etcd enabled
====================================

This is a Docker image with RabbitMQ server, running the latest version,
on Arch Linux. It synchronizes RabbitMQ vhosts, users and permissions,
using hosts etcd. This is done with simple Python script running in background.
This image is intended to be used on CoreOS host.

Installation
------------

With docker:
```sh
/usr/bin/docker run --env-file /etc/environment -p 5672:5672 -p 15672:15672 skrat/rabbitmq-etcd
```

Synchronization script expects `COREOS_PRIVATE_IPV4` variable to be host's
IP address. It uses it access etcd, and publish its own location to etcd.

With fleet:
```sh
git clone https://github.com/skrat/rabbitmq-etcd.git
fleetctl start rabbitmq-etcd/rabbitmq.service
```

Usage
-----

Creating vhost:
```sh
etcdctl set /rabbitmq/vhosts/example 1
```

Deleting vhost:
```sh
etcdctl rm /rabbitmq/vhosts/example
```

Creating user:
```sh
etcdctl set /rabbitmq/users/john secret
```

Deleting user:
```sh
etcdctl rm /rabbitmq/users/john
```

Setting permissions:
```sh
etcdctl set /rabbitmq/permissions/example/john ".*/.*/.*"
```
