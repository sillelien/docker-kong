#!/usr/bin/env bash

envsubst '$CASSANDRA_PORT_9042_TCP_ADDR:$CASSANDRA_PORT_9042_TCP_PORT' < /kong.yml > /etc/kong/kong.yml
while ! kong start
do
    sleep 10
done
