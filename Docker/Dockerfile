# Base Image
FROM nginx:latest

# Maintainer Information
LABEL maintainer="Ahmed Ezzat <a7med.3zat96@gmail.com>" \
      project="DevOps Project" \
      version="1.1"

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy all website files
COPY . .

# Expose port 80 inside container
EXPOSE 80

# Environment variables
ENV PROJECT_ENV=production \
    AUTHOR="DevOps Team"

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Keep nginx running in foreground
CMD ["nginx", "-g", "daemon off;"]

