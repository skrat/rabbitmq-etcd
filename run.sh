#!/bin/sh

# Monitor mode for job control, allows fg in the last line
set -o monitor

# Reads RabbitMQ environment and starts server in the backgroun
source /etc/rabbitmq/rabbitmq-env.conf
/usr/bin/rabbitmq-server &

waits=1

while true ; do
    sleep $waits
    echo "=> Waiting $waits seconds for RabbitMQ to boot..."
    curl -u guest:guest http://localhost:15672/api/vhosts &> /dev/null
    [ $? -eq 0 ] && break
    waits=$(($waits * 2))
done

logfile=/var/log/rabbitmq/$RABBITMQ_NODENAME.log

echo "=> Redirecting log file $logfile to stdout"
(
    tail -F /var/log/rabbitmq/$RABBITMQ_NODENAME.log | while read line ; do
        echo $line
    done
) &

echo "=> Starting configsync.py in the background"
/configsync.py & fg %1 > /dev/null
