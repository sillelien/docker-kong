#!/usr/bin/env bash

envsubst '$CASSANDRA_PORT_9042_TCP_ADDR:$CASSANDRA_PORT_9042_TCP_PORT' < /kong.yml > /etc/kong/kong.yml

while ! ping -c 1 $CASSANDRA_PORT_9042_TCP_ADDR
do
    sleep 5
done

env_vars=$(env | grep ".*_NAME=" | cut -d= -f1 | tr '\n' ' ')
echo "#Auto Generated - DO NOT CHANGE" >> /etc/hosts
for env_var in $env_vars
do
  link=${env_var%_NAME}
  domain=$(cat /etc/resolv.conf | grep search | cut -d' ' -f2)
  nameserver=$(cat /etc/resolv.conf | grep nameserver | head -1 | cut -d' ' -f2)
  ip=$(nslookup "${link}.${domain}" ${nameserver}  | grep Address | tail -1 | cut -d: -f2  | cut -d' ' -f2)
  if [ -n "$ip" ]
  then
    echo "${ip} ${link}" >> /etc/hosts
  else
    logger "ip ${link}.${domain} skipped, it didn't resolve."
  fi
done

count=1
while ! kong start
do
    sleep 10
    count=$(( count + 1 ))
    (( count < 10 ))
done
