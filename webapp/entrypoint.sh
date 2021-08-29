#!/bin/sh

nohup /root/webapp/p2pclient -l $email >> /root/webapp/test.log 2>&1 &
gunicorn --bind 0.0.0.0:${PORT} wsgi 