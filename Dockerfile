# Use official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools
RUN apt-get update && apt-get install -y \
    sudo curl wget git nano htop iproute2 net-tools \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user (Railway runs as root otherwise)
RUN useradd -m -s /bin/bash railway && echo "railway:railway" | chpasswd && adduser railway sudo

# Set working directory
WORKDIR /home/railway

# Start bash by default
CMD ["/bin/bash"]
