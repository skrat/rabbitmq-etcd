#!/bin/bash

if [ -f /.configured ]; then
	echo "RabbitMQ password already set!"
	exit 0
fi

# We will run rabbitmq-server as root, thus chown all its data
chown root:root -R /var/lib/rabbitmq /var/log/rabbitmq /etc/rabbitmq

# We need constant fully qualified node name, because hostname changes
echo "RABBITMQ_NODENAME=rabbitmq@localhost" >> /etc/rabbitmq/rabbitmq-env.conf

touch /.configured

