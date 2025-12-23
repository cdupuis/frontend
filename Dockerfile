#syntax=docker/dockerfile:1

#=== Build stage: Install dependencies ===#
FROM dhi.io/node:25-debian13-dev@sha256:22c6d58cc8c1b3f26de4bb95821ba1a5216247539b7194dce49eb2e3f46890a0 AS builder

WORKDIR /app

COPY package.json ./

RUN npm i --no-optional && npm cache clean --force

#=== Final stage: Create minimal runtime image ===#
FROM dhi.io/node:25-debian13@sha256:1e29f3bb4642388403ed6ff24a580b5e9a9b50807150f85a30d3dabf63804e4c

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

WORKDIR /app

COPY --from=builder --chown=node:node /app/node_modules ./node_modules

COPY --chown=node:node . /app

CMD ["node","/app/app.js"]

EXPOSE 3000


