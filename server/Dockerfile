# Specify a base image
FROM node:14.14.0-alpine
WORKDIR /app

# Install some depenendencies
COPY package.json .
RUN npm install
COPY . .

# Default command
CMD ["npm", "run", "start"]
