#!/bin/sh
set -e  # Exit immediately if any command fails

# Environment variables (use the standard MYSQL_* variables from compose)
ROOT_PASS="${MYSQL_ROOT_PASSWORD}"
APP_DB_NAME="${MYSQL_DATABASE:-wordpress}"
APP_DB_USER="${MYSQL_USER:-wpuser}"
APP_DB_PASS="${MYSQL_PASSWORD}"

# Function to start MariaDB temporarily without auth
start_temp_mariadb() {
    echo "Starting MariaDB temporarily without authentication..."
    mysqld_safe --skip-grant-tables --skip-networking &
    pid="$!"

    # Wait for MariaDB socket to be ready
    until mysqladmin ping > /dev/null 2>&1; do
        sleep 1
    done
}

# Function to stop temporary MariaDB
stop_temp_mariadb() {
    echo "Stopping temporary MariaDB..."
    mysqladmin -uroot -p"${ROOT_PASS}" shutdown || kill "$pid"
}

# Initialize database only if it’s empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Start temporary MariaDB
start_temp_mariadb


# Create root password and application database/user safely
echo "Setting root password and creating database '${APP_DB_NAME}' and user '${APP_DB_USER}'..."
mysql <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS \`${APP_DB_NAME}\`;
CREATE USER IF NOT EXISTS '${APP_DB_USER}'@'%' IDENTIFIED BY '${APP_DB_PASS}';
GRANT ALL PRIVILEGES ON \`${APP_DB_NAME}\`.* TO '${APP_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop temporary MariaDB
stop_temp_mariadb

# Start MariaDB normally
echo "Starting MariaDB normally..."
exec mysqld_safe --datadir=/var/lib/mysql
