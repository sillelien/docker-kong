#!/usr/bin/env bash
set -ex

cd /tmp
apt-get update
apt-get install -y netcat lua5.1 openssl libpcre3 dnsmasq curl sudo gettext
curl -L https://github.com/Mashape/kong/releases/download/0.4.0/kong-0.4.0.wheezy_all.deb > kong-0.4.0.wheezy_all.deb
dpkg -i kong-0.4.0.*.deb
rm /tmp/*