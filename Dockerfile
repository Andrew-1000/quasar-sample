FROM node:16.14.2 as build
WORKDIR /app
COPY package*.json .
RUN npm install
RUN npm install @quasar/cli
COPY . .
RUN quasar build

FROM nginx:1.18
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
