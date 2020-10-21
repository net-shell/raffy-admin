FROM php:fpm

WORKDIR /usr/share/nginx/html

# Install PDO
RUN docker-php-ext-install pdo pdo_mysql

# Install GD, ZIP
RUN apt-get update -y && apt-get install -y libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6-dev libonig-dev
RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif

# Install Redis
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer --version

#RUN composer run-script install-tasks
