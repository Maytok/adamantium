# build environment
FROM node:16.19.1 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

# production environment
FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /app
COPY default.conf /etc/nginx/nginx.conf
