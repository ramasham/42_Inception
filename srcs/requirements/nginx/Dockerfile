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

# Expose HTTPS and HTTP ports
EXPOSE 443 80

# Start NGINX in foreground (PID 1)
#deamon -> just a program that runs in the background,
#detached from your terminal

#when you run nginx normally, it forks:
    #1. the first process(the one you started) exits
    #2. a new "master" process continus running in the background
# that's called deamonizing

#daemon off -> Normally, Nginx runs as a daemon (background process).
#tells Nginx not to fork into the background, run in the foreground.
#foreground -> a process that runs directly and stays attached to the terminal or PID 1.
#Why foreground is important in Docker?
#Docker containers rely on PID 1 to define the container’s lifecycle.
#If the main process daemonizes (goes to background):
    # PID 1 exits → Docker thinks the container is finished → container stops immediately.

#What happens if Nginx daemonizes (background)
#Nginx will:
    #1. Fork a background worker process.
    #2. Exit the master process that Docker started (which was PID 1).
#Docker sees PID 1 exit → thinks the container has finished → stops all other
#processes (including the background Nginx workers).

#Here, "daemon off;" is a directive normally written inside nginx.conf,
#but we’re passing it via -g so we don’t have to edit the config file.
#It tells Nginx not to daemonize, i.e., to stay in the foreground.
CMD ["nginx", "-g", "daemon off;"]