FROM node:10

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
# Create app directory
WORKDIR /home/node/app

# Installing dependencies
COPY package*.json ./
USER node
RUN npm install
COPY --chown=node:node . .
# Copying source files
EXPOSE 3000
# Running the app
CMD [ "npm", "start" ]


