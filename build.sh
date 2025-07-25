# #!/usr/bin/env bash

# echo "🚀 Running build.sh for Laravel on Render..."

# # Install composer dependencies (optimized for production)
# composer install --no-dev --optimize-autoloader

# # Set Laravel storage link
# php artisan storage:link

# # Clear and cache configurations
# php artisan config:clear
# php artisan config:cache
# php artisan route:cache
# php artisan view:cache

# # Run migrations
# php artisan migrate --force

# echo "✅ Laravel build & setup completed!"

#!/usr/bin/env bash
echo "Running composer"

composer install --no-dev --working-dir=/var/www/html

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Publishing cloudinary provider..."
php artisan vendor:publish --provider="CloudinaryLabs\CloudinaryLaravel\CloudinaryServiceProvider" --tag="cloudinary-laravel-config"

echo "Running migrations..."
php artisan migrate --force
