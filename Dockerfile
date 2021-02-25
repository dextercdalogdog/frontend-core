### STAGE 1: Build ###
FROM node:14 AS build

# Create app directory
WORKDIR /frontend/core

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

RUN node_modules/.bin/ng build --prod


### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /frontend/core/dist/frontend-core /usr/share/nginx/html
