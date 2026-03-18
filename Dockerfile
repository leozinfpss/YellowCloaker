FROM php:8.1-apache

# Desativa todos os MPMs e ativa só o prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_* && \
    ln -s /etc/apache2/mods-available/mpm_prefork.load /etc/apache2/mods-enabled/mpm_prefork.load && \
    ln -s /etc/apache2/mods-available/mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf && \
    a2enmod rewrite

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
