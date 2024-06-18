FROM alpine:3.20@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

RUN apk add --no-cache \
  nodejs curl openssl

COPY package.json ./

RUN  apk add --no-cache npm && npm i --no-optional && npm cache clean --force && apk del npm
 
COPY . /app

RUN adduser -D appuser
USER appuser

CMD ["node","/app/app.js"]

EXPOSE 3000
