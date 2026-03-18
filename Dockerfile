FROM php:8.1-fpm-alpine

RUN apk add --no-cache nginx gettext

COPY . /var/www/html/
COPY nginx.conf /etc/nginx/http.d/default.conf

RUN chown -R www-data:www-data /var/www/html

COPY start.sh /start.sh
RUN chmod +x /start.sh && \
    sed -i 's/\r//' /start.sh

EXPOSE 80
CMD ["/start.sh"]
