#!/usr/bin/env bash

envsubst '$CASSANDRA_PORT_9042_TCP_ADDR:$CASSANDRA_PORT_9042_TCP_PORT' < /kong.yml > /etc/kong/kong.yml

while ! ping -c 1 $CASSANDRA_PORT_9042_TCP_ADDR
do
    sleep 5
done

count=1
while ! kong start
do
    sleep 10
    count=$(( count + 1 ))
    (( count < 10 ))
done
