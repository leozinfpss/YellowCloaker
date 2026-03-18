FROM php:8.1-fpm-alpine

# Instala nginx
RUN apk add --no-cache nginx

# Copia os arquivos do cloaker
COPY . /var/www/html/

# Permissões
RUN chown -R www-data:www-data /var/www/html

# Configuração do nginx
RUN echo 'server {
    listen 80;
    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}' > /etc/nginx/http.d/default.conf

# Script de inicialização
RUN echo '#!/bin/sh
php-fpm -D
nginx -g "daemon off;"' > /start.sh && chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]
