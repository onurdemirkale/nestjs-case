FROM node:12

WORKDIR /app

COPY package.json yarn.lock ./

# install the application dependencies using Yarn
RUN yarn install

COPY . .

# build the application
RUN yarn build

# remove development dependencies
RUN yarn install --production

EXPOSE 3000

CMD ["yarn", "start:prod"]
