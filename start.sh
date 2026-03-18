#!/bin/sh
echo "PORT: $PORT"
which nginx
nginx -v
php-fpm -D
sleep 2
envsubst '$PORT' < /etc/nginx/http.d/default.conf > /tmp/nginx.conf
cp /tmp/nginx.conf /etc/nginx/http.d/default.conf
nginx -t
nginx -g "daemon off;"
