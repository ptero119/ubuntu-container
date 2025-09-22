# Use official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools
RUN apt-get update && apt-get install -y \
    sudo curl wget git nano htop iproute2 net-tools \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user (Railway runs as root otherwise)
RUN useradd -m -s /bin/bash railway && echo 'railway:railway' | chpasswd && adduser railway sudo

# Download ttyd (web terminal)
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 \
    && chmod +x ttyd.x86_64 \
    && mv ttyd.x86_64 /usr/local/bin/ttyd

# Set working directory
WORKDIR /home/railway

# Expose port 8080 (for ttyd web terminal)
EXPOSE 8080

# Start ttyd with bash
CMD ["ttyd", "-p", "8080", "bash"]
