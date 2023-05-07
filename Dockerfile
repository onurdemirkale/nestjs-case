# Choose an official Node.js base image
FROM node:12

# Set the working directory for your application
WORKDIR /app

# Copy package.json and yarn.lock files to the working directory
COPY package.json yarn.lock ./

# Install the application dependencies using Yarn
RUN yarn install

# Copy the rest of the application files to the working directory
COPY . .

# Build the application
RUN yarn build

# Remove development dependencies
RUN yarn install --production

# Expose the port the application will run on
EXPOSE 3000

# Start the Nest.js application
CMD ["yarn", "start:prod"]
