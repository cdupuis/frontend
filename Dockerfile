FROM node:23

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

COPY package.json ./

RUN npm i --no-optional && npm cache clean --force
 
COPY . /app

CMD ["node","/app/app.js"]

EXPOSE 3000
