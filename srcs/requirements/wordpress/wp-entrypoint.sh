#!/bin/bash

# Download and setup WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Set permissions for WordPress directory
cd /var/www/html
chmod -R 755 /var/www/html

# Fix PHP-FPM socket port
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Parse DB host/port from WORDPRESS_DB_HOST (format: host[:port])
DB_HOST="${WORDPRESS_DB_HOST%%:*}"
DB_PORT="${WORDPRESS_DB_HOST#*:}"
if [ "${DB_PORT}" = "${WORDPRESS_DB_HOST}" ]; then
    DB_PORT=3306
fi

# Simplify the way we check for MariaDB availability
echo "Waiting for MariaDB at ${DB_HOST}:${DB_PORT}..."
ready=0
for i in $(seq 1 60); do
    if nc -z ${DB_HOST} ${DB_PORT} 2>/dev/null; then
        ready=1
        echo "MariaDB port is reachable after $i attempts"
        break
    fi
    echo "Attempt $i: MariaDB port not reachable yet, waiting..."
    sleep 5
done

# Download WordPress core regardless (safe op)
echo "Downloading WordPress core..."
wp core download --allow-root || true

if [ "$ready" -eq 1 ]; then
    echo "MariaDB is ready, configuring WordPress..."
    
    # Check if wp-config.php already exists
    if [ ! -f wp-config.php ]; then
        echo "Creating wp-config.php..."
        # Create wp-config.php using provided env vars
        wp config create \
            --dbname="${WORDPRESS_DB_NAME}" \
            --dbuser="${WORDPRESS_DB_USER}" \
            --dbpass="${WORDPRESS_DB_PASSWORD}" \
            --dbhost="${WORDPRESS_DB_HOST}" \
            --allow-root
        echo "wp-config.php created successfully"
    else
        echo "wp-config.php already exists"
    fi

    # Install WordPress (ignore if already installed)
    echo "Installing WordPress core..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Inception WordPress" \
        --admin_user=admin \
        --admin_password=admin123 \
        --admin_email=admin@${DOMAIN_NAME} \
        --skip-email \
        --allow-root || \
        echo "WordPress core already installed"
else
    echo "WARNING: MariaDB at ${DB_HOST}:${DB_PORT} not reachable after multiple attempts."
    echo "WordPress configuration and installation will be skipped."
    echo "Please check the MariaDB container and network configuration."
fi

# Create additional WordPress user only if we're ready
if [ "$ready" -eq 1 ]; then
    # Create additional WordPress user (only if it doesn't exist)
    echo "Creating additional user..."
    wp user create user1 user1@${DOMAIN_NAME} \
        --user_pass=user123 \
        --role=editor --allow-root || echo "User already exists or could not be created"

    # Install theme
    echo "Installing theme..."
    wp theme install twentytwentyfour --activate --allow-root || echo "Theme installation failed"
fi

# Fix ownership
echo "Setting correct file permissions..."
chown -R www-data:www-data /var/www/html

# Remove the simple health check file if it exists
if [ -f /var/www/html/index.php ] && grep -q "WordPress container is running" /var/www/html/index.php; then
    echo "Removing health check file..."
    rm /var/www/html/index.php
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
