FROM debian:bullseye

# Install Redis with apt (Debian) instead of apk (Alpine)
RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# Create directory for redis data
RUN mkdir -p /data && chown redis:redis /data

# Copy redis config
COPY conf/redis.conf /etc/redis.conf

# Expose default port
EXPOSE 6379

# Run redis with custom config
CMD ["redis-server", "/etc/redis.conf"]
