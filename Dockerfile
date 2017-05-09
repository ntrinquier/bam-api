FROM node:7.10-alpine

ENV DOCKERIZE_VERSION v0.4.0
RUN apk add --no-cache --virtual .build-deps curl \
    && curl -fSL  -o dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /srv
COPY . /srv
RUN yarn install

CMD dockerize -wait tcp://db:5432 -timeout 10s && yarn start
