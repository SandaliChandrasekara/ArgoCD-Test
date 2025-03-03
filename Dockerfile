FROM node:latest

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY src/ ./src
COPY public/ ./public
COPY templates/ ./templates
COPY src/utils/ ./src/utils

EXPOSE 3000

CMD ["node", "src/app.js"]

