FROM php:8.1-apache

# Remove MPM duplicado e usa só o prefork
RUN a2dismod mpm_event mpm_worker 2>/dev/null || true && \
    a2enmod mpm_prefork rewrite

# Copia os arquivos do cloaker
COPY . /var/www/html/

# Permissões
RUN chown -R www-data:www-data /var/www/html

# Configura AllowOverride para o .htaccess funcionar
RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' >> /etc/apache2/apache2.conf

EXPOSE 80
