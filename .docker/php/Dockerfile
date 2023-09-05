FROM php:fpm

WORKDIR /usr/share/nginx/html

# Install PDO
RUN docker-php-ext-install pdo pdo_mysql

# Install GD, ZIP, etc.
RUN apt-get update -y && apt-get install -y -qq --force-yes libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6-dev libonig-dev supervisor zlib1g-dev cron libgmp-dev
RUN apt-get install -y libzip-dev
# Configure GD
RUN docker-php-ext-configure gd --with-freetype --with-webp  --with-jpeg
RUN docker-php-ext-install zip gd gmp exif

# Install Redis
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer --version


# Copy cron file to the cron.d directory
COPY cron.txt /etc/cron.d/app-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/app-cron

# Apply cron job
RUN crontab /etc/cron.d/app-cron

#RUN composer run-script install-tasks
