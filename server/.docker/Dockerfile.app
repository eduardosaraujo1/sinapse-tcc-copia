FROM node:24-alpine

WORKDIR /app

COPY www/package*.json .

RUN npm install

COPY ./www .

EXPOSE 8000

CMD ["node", "server.js"]
