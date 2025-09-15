FROM debian:bookworm

# Install dependencies and update certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates wget file && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set cAdvisor version
ENV CADVISOR_VERSION="v0.47.2"

# Detect architecture and download correct cAdvisor binary
RUN ARCH=$(dpkg --print-architecture) && \
    echo "System architecture: $ARCH" && \
    if [ "$ARCH" = "amd64" ]; then \
        wget -O /usr/bin/cadvisor "https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-amd64"; \
    elif [ "$ARCH" = "arm64" ]; then \
        wget -O /usr/bin/cadvisor "https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-arm64"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    chmod +x /usr/bin/cadvisor && \
    file /usr/bin/cadvisor

WORKDIR /

# Expose port
EXPOSE 8080

# Set healthcheck
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Run cAdvisor in docker-only mode to avoid rootfs warnings
CMD ["/usr/bin/cadvisor", "--docker_only"]

