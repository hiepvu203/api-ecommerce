FROM php:8.2-apache

# Cài các extension cần thiết
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip gd

# Bật mod_rewrite cho Apache
RUN a2enmod rewrite

# Cài Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Làm việc trong thư mục này
WORKDIR /var/www/html

# Copy toàn bộ code
COPY . .

# Cấp quyền
RUN chown -R www-data:www-data /var/www/html

# Cài Laravel
RUN composer install --no-dev --optimize-autoloader

# Cache config Laravel
RUN php artisan config:cache

# Cổng mặc định Apache
EXPOSE 80

# 👇 Đây là dòng quan trọng
CMD ["apache2-foreground"]
