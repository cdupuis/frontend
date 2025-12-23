#syntax=docker/dockerfile:1

#=== Build stage: Install dependencies ===#
FROM dhi.io/node:24-debian13-dev@sha256:0a90afadabdddcdd7e9eecef7048e5a0f1f45e6f165c2a035be091f1efd2255e AS builder

WORKDIR /app

COPY package.json ./

RUN npm i --no-optional && npm cache clean --force

#=== Final stage: Create minimal runtime image ===#
FROM dhi.io/node:24-debian13@sha256:e805d972f53c2db92cab8c56242ba8609736e461ef16d4073d52d5404263bbc9

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
