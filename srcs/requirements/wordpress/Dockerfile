FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install PHP, PHP-FPM, WP-CLI dependencies, unzip, wget, curl with time validation disabled
#These flags tell APT to ignore date/time checks when downloading package information
#You need this because your system time appears to be ahead of the Debian repository servers (by about 10 hours)
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y --no-install-recommends \
        php php-cli php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip \
        php-redis \
        unzip wget curl less mariadb-client netcat-openbsd ca-certificates && \
    update-ca-certificates && \
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
