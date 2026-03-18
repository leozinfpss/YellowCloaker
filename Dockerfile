FROM php:8.1-apache

# Habilita mod_rewrite (necessário para o .htaccess do cloaker)
RUN a2enmod rewrite

# Copia todos os arquivos do cloaker para o servidor
COPY . /var/www/html/

# Permissões
RUN chown -R www-data:www-data /var/www/html

# Configura o Apache para aceitar .htaccess
RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' >> /etc/apache2/apache2.conf

EXPOSE 80
```
