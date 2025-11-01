# Base Image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy all website files
COPY . .

# Expose port 80 inside container
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Keep nginx running in foreground
CMD ["nginx", "-g", "daemon off;"]


