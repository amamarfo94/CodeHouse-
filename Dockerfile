# Start from node image
FROM node:12

# Set work directory
WORKDIR /tmp/src/

# Copy files
COPY . . 

# Install required packages
COPY ./app/package*.json ./app/
RUN cd ./app && npm install

# Expose port 3000
EXPOSE 3000

# Run the app
CMD cd ./app && npm start
