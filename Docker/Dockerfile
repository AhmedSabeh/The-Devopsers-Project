# Base Image
FROM nginx:latest

# Install curl and upgrade system packages to fix CVEs
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy website files
COPY . .

# Expose port 80 inside container
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Keep nginx running in foreground
CMD ["nginx", "-g", "daemon off;"]

