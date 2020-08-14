FROM php:7.3.6-fpm-alpine3.9

RUN apk add openssl bash mysql-client nodejs npm
RUN apk add --no-cache shadow
RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
    
WORKDIR /var/www
RUN rm -rf /var/www/html
COPY . /var/www

RUN ln -s public html

#RUN composer install && \
#	php artisan key:generate && \
#	php artisan cache:clear && \
#	chmod -R 775 storage

#RUN npm install

#RUN usermod -u 1000 www-data
#USER www-data


EXPOSE 9000

ENTRYPOINT ["php-fpm"]
