FROM node:19
WORKDIR /nordic/client
COPY client/package.json .
RUN npm install
COPY /client .

RUN npm run build

CMD ["npm","run","dev"]

EXPOSE 5000