# Stage 1: Build the application
FROM node:18.16.1-alpine AS build

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application source code
COPY ./build .

# Stage 2: Create the production image
FROM node:18.16.1-alpine

WORKDIR /usr/src/app

# Copy the built artifacts from the previous stage
COPY --from=build /usr/src/app .

# Expose the port
EXPOSE 8080

# Command to run the application
CMD ["npm", "start"]
