#!/bin/sh

nohup /root/webapp/p2pclient -l $email >> /root/webapp/test.log 2>&1 &
# check wheterh port is null
if [ -z "$PORT" ]; then
    PORT=5000
fi
gunicorn --bind 0.0.0.0:${PORT} wsgi 