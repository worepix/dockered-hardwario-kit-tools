#!/bin/bash

set -e

echo "Starting nginx"
service nginx start

echo "Starting mosquitto"
service mosquitto start

echo "Run Supervisor"
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

while true; do sleep 1000; done