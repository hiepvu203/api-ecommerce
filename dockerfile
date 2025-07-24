FROM php:8.2-apache

# Cài tiện ích hệ thống và PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libonig-dev \
    libzip-dev \
    libxml2-dev \
    libpng-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip xml gd

# Bật mod_rewrite
RUN a2enmod rewrite

# Cài Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set thư mục làm việc
WORKDIR /var/www/html

# Copy mã nguồn vào container
COPY . /var/www/html

# Cấp quyền cho Laravel
RUN chown -R www-data:www-data /var/www/html

# Cài gói và cache config Laravel
RUN composer install --no-dev --optimize-autoloader \
    && php artisan config:cache \
    && php artisan route:cache \
    && php artisan view:cache

EXPOSE 80
