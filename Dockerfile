#syntax=docker/dockerfile:1

#=== Build stage: Install dependencies ===#
FROM node:25 AS builder

COPY ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENV NODE_USE_ENV_PROXY=1 \
  NO_PROXY=localhost,127.0.0.1,::1,gateway.docker.internal \
  HTTPS_PROXY=http://gateway.docker.internal:3128 \
  HTTP_PROXY=http://gateway.docker.internal:3128 \
  NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt \
  NODE_USE_ENV_PROXY=1

WORKDIR /app

COPY package.json ./

RUN npm i --no-optional && npm cache clean --force

#=== Final stage: Create minimal runtime image ===#
FROM node:25

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY . /app

CMD ["node","/app/app.js"]

EXPOSE 3000
