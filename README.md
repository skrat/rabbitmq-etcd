RabbitMQ docker image / etcd enabled
====================================

This is a Docker image with RabbitMQ server, running the latest version,
on Arch Linux. It synchronizes RabbitMQ vhosts, users and permissions,
using hosts etcd. This is done with simple Python script running in background.
This image is intended to be used on CoreOS host.

Installation
------------

With docker:
```
/usr/bin/docker run                 \
        --env-file /etc/environment \
        -p 5672:5672                \
        -p 15672:15672              \
        skrat/rabbitmq-etcd
```

Synchronization script expects `COREOS_PRIVATE_IPV4` variable to be host's
IP address. It uses it access etcd, and publish its own location to etcd.

With fleet:
```
git clone https://github.com/skrat/rabbitmq-etcd.git
fleetctl start rabbitmq-etcd/rabbitmq.service
```

Usage
-----

Creating vhost:

```
etcdctl set /rabbitmq/vhosts/example 1
```

Deleting vhost:

```
etcdctl rm /rabbitmq/vhosts/example
```

Creating user:

```
etcdctl set /rabbitmq/users/john secret
```

Creating user with tags:

```
etcdctl set /rabbitmq/tags/john management,administrator
etcdctl set /rabbitmq/users/john secret
```

Deleting user:

```
etcdctl rm /rabbitmq/users/john
```

Setting permissions:

```
etcdctl set /rabbitmq/permissions/example/john ".*/.*/.*"
```
