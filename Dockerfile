FROM php:8.1-apache

RUN sed -i 's/^#\(.*mpm_prefork\)/\1/' /etc/apache2/mods-enabled/mpm_event.conf 2>/dev/null || true && \
    phpdismod mpm_event 2>/dev/null || true && \
    a2dismod mpm_event 2>/dev/null || true && \
    a2enmod mpm_prefork rewrite 2>/dev/null || true

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

RUN echo '<Directory /var/www/html>\nAllowOverride All\nRequire all granted\n</Directory>' \
    >> /etc/apache2/apache2.conf

EXPOSE 80
