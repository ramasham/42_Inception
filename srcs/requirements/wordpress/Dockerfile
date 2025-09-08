FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install PHP, PHP-FPM, WP-CLI dependencies, unzip, wget, curl
RUN apt-get update && \
    apt-get install -y \
        php php-cli php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip \
        unzip wget curl less mariadb-client netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /var/www/html

# Copy the entrypoint script
COPY wp-entrypoint.sh /wp-entrypoint.sh
RUN chmod +x /wp-entrypoint.sh

# Expose PHP-FPM port
EXPOSE 9000

# Use the entrypoint script
ENTRYPOINT ["/wp-entrypoint.sh"]
