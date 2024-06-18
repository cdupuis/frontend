FROM alpine:3.20@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

RUN apk add --no-cache \
  nodejs curl

COPY package.json ./

RUN  apk add --no-cache npm && npm i --no-optional && npm cache clean --force && apk del npm
 
COPY . /app

RUN adduser -D appuser
USER appuser

CMD ["node","/app/app.js"]

EXPOSE 3000
