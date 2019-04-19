FROM node:alpine as builder

WORKDIR /usr/app

# Install some dependencies
COPY ./package.json .
RUN npm install --no-package-lock
COPY . .
RUN npm run build

# /usr/app/build <-- all the stuff

FROM nginx as deploy
EXPOSE 80
COPY --from=builder  /usr/app/build /usr/share/nginx/html
# CMD ["nginx"] works by default