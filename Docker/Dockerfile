# Use a lightweight Nginx image
FROM nginx:alpine

# Set the working directory to Nginx's default html folder
WORKDIR /usr/share/nginx/html

# Remove the default Nginx static files
RUN rm -rf ./*

# Copy all your local website files into the container
COPY . .

# Expose port 80 so it can be accessed from outside
EXPOSE 4600

