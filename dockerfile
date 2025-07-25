# FROM php:8.2-apache

# # Cài các extension cần thiết
# RUN apt-get update && apt-get install -y \
#     git \
#     zip \
#     unzip \
#     libpng-dev \
#     libonig-dev \
#     libzip-dev \
#     libpq-dev \
#     && docker-php-ext-install pdo pdo_pgsql mbstring zip gd

# # Bật mod_rewrite cho Apache
# RUN a2enmod rewrite

# # Cài Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # Làm việc trong thư mục này
# WORKDIR /var/www/html

# # Copy toàn bộ code
# COPY . .

# # Cấp quyền
# RUN chown -R www-data:www-data /var/www/html

# # Cài Laravel
# RUN composer install --no-dev --optimize-autoloader

# # Cache config Laravel
# RUN php artisan config:cache

# # Cổng mặc định Apache
# EXPOSE 80

# # 👇 Đây là dòng quan trọng
# CMD ["apache2-foreground"]

FROM richarvey/nginx-php-fpm:latest

COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr


# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/start.sh"]
