#!/bin/bash

# Download and setup WP-CLI with SSL verification disabled
curl -k -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
if [ -f wp-cli.phar ]; then
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
    echo "WP-CLI installed successfully"
else
    echo "Failed to download WP-CLI"
    exit 1
fi

# Set permissions for WordPress directory
cd /var/www/html
chmod -R 755 /var/www/html

# Fix PHP-FPM socket port
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
PHP_FPM_POOL_FILE="/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

if [ -f "$PHP_FPM_POOL_FILE" ]; then
    sed -i 's/listen = \/run\/php\/php.*-fpm.sock/listen = 9000/g' "$PHP_FPM_POOL_FILE"
    echo "PHP-FPM configured to listen on port 9000"
else
    echo "PHP-FPM config file not found at $PHP_FPM_POOL_FILE"
fi

# Parse DB host/port from WORDPRESS_DB_HOST
DB_HOST="${WORDPRESS_DB_HOST%%:*}"
DB_PORT="${WORDPRESS_DB_HOST#*:}"
if [ "${DB_PORT}" = "${WORDPRESS_DB_HOST}" ]; then
    DB_PORT=3306
fi

# Wait for MariaDB to be ready
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

# Download WordPress core
echo "Downloading WordPress core..."
wp core download --allow-root --insecure || true

# Fallback manual download if needed
if [ ! -f /var/www/html/wp-config-sample.php ]; then
    echo "Trying manual WordPress download..."
    curl -k -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /tmp
    cp -r /tmp/wordpress/* /var/www/html/
    rm -rf /tmp/wordpress /tmp/wordpress.tar.gz
    echo "Manual WordPress download completed"
fi

if [ "$ready" -eq 1 ]; then
    echo "MariaDB is ready, configuring WordPress..."

    # Create wp-config.php if it doesn't exist
    if [ ! -f wp-config.php ]; then
        echo "Creating wp-config.php..."
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

    # Install WordPress only if not installed
    if ! wp core is-installed --allow-root; then
        echo "Installing WordPress core..."
        wp core install \
            --url="${DOMAIN_NAME}" \
            --title="Inception WordPress" \
            --admin_user=superuser \
            --admin_password=super123 \
            --admin_email=superuser@${DOMAIN_NAME} \
            --skip-email \
            --allow-root
        echo "WordPress installed successfully"
    else
        echo "WordPress is already installed"
    fi

    # Create second user if it doesn't exist
    if ! wp user get user1 --allow-root > /dev/null 2>&1; then
        echo "Creating additional user..."
        wp user create user1 user1@${DOMAIN_NAME} \
            --user_pass=user123 \
            --role=editor --allow-root
    else
        echo "User 'user1' already exists"
    fi

    # Install and activate theme
    wp theme install twentytwentyfour --activate --allow-root || echo "Theme installation failed"

    # --- Redis Setup ---
    echo "Configuring Redis cache..."
    wp config set WP_CACHE true --raw --type=constant --allow-root
    wp config set WP_REDIS_HOST redis --type=constant --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --type=constant --allow-root

    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
    echo "Redis cache enabled successfully"

fi

# Set correct ownership
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
echo "Starting PHP-FPM..."
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F

