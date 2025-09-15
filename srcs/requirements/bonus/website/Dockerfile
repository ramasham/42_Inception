FROM debian:bullseye

# Install minimal dependencies
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Create directory for website files
RUN mkdir -p /website

# Copy website files
COPY index.html /website/index.html

# Use a simple command to keep container running
CMD ["sleep", "infinity"]
