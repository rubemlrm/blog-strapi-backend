# Base image
FROM node:20-alpine AS build

# Create app directory
WORKDIR /app

# Copy dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy project files
COPY . .

# Build Strapi admin panel
RUN npm run build

FROM node:20-alpine AS runtime

COPY --from=build /app ./

# Expose port & start server
EXPOSE 1337
CMD ["npm", "run", "start"]
