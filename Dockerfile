FROM node:16.14.2 as build
WORKDIR /quasarapp
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm install -g @quasar/cli
RUN quasar build

FROM nginx:1.18
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /quasarapp/dist /usr/share/nginx/html
