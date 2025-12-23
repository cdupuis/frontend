#syntax=docker/dockerfile:1

#=== Build stage: Install dependencies ===#
FROM dhi.io/node:24-debian13-dev AS builder

WORKDIR /app

COPY package.json ./

RUN npm i --no-optional && npm cache clean --force

#=== Final stage: Create minimal runtime image ===#
FROM dhi.io/node:24-debian13

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
