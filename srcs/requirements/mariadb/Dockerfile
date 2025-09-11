FROM debian:bullseye

# Install MariaDB server and required tools with time validation disabled
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom MariaDB configuration
COPY my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Run the init script (instead of mysqld directly)
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Expose default port
EXPOSE 3306
# Start MariaDB server
CMD ["/init.sh"]
