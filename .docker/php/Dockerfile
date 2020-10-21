FROM php:fpm

WORKDIR /usr/share/nginx/html

RUN docker-php-ext-install pdo_mysql

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer --version

#RUN composer run-script install-tasks
