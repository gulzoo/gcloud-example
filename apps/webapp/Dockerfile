FROM node:14.19.0-alpine AS build
COPY package.json /app/
COPY package-lock.json /app/
WORKDIR /app
RUN npm ci
COPY ./src/ /app/src/
COPY ./scripts/ /app/scripts/
RUN npm run build

FROM nginx:1.21.6-alpine
COPY --from=build /app/dist/ /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/conf.d/
RUN chown -R nginx:nginx /usr/share/nginx/html/
