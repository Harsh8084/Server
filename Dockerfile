# Use the official Node.js image as a base image
FROM node:16

# Install necessary packages
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    apt-get update && \
    curl -sSL https://get.docker.com/ | sh && \
    apt-get install -y docker redis-server && \
    rm -rf /var/lib/apt/lists/*

#  Use the environment variables in your application code
ENV NODE_ENV=production
ENV PORT=5000
ENV CONTAINERIZED=true

# Create a directory for the Node.js server code
WORKDIR /app

# Copy the Node.js server code into the container
COPY . .

# Install the dependencies
RUN npm install



# Expose the necessary ports
EXPOSE 5000

# Start the Node.js server
CMD ["/bin/bash", "-c", "redis-server & npm start"]
