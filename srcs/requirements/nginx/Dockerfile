FROM debian:bullseye

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install NGINX, OpenSSL, and curl with time validation disabled
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y --no-install-recommends nginx openssl curl && \
    rm -rf /var/lib/apt/lists/*
    
# Create directory for SSL
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed TLS certificate
RUN openssl req -x509 -nodes -days 365 \
    -subj "/CN=rsham.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

# Copy NGINX config
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/mime.types /etc/nginx/mime.types

# Expose HTTPS port
EXPOSE 443

# Start NGINX in foreground (PID 1)
CMD ["nginx", "-g", "daemon off;"]