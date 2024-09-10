# Stage 1: Install dependencies
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install all dependencies (including devDependencies)
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Stage 2: Production image
FROM node:18-alpine

# Install PM2 globally
RUN npm install -g pm2

# Set the working directory in the new image
WORKDIR /app

# Copy only the production dependencies from the build stage
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package*.json /app/

# Copy the source code from the build stage
COPY --from=build /app /app

# Expose the port your application runs on (adjust if necessary)
EXPOSE 3000

# Start the application using PM2
CMD ["pm2-runtime", "start", "app.js"]
