#build phase

FROM node:16-alpine as builder 

USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build 


#Run phase
#Specifying from means a new phase
#a single phase can have a single from statement

From nginx
#Copy build folder from previous phase to new phase
COPY --from=builder /home/node/app/build  /usr/share/nginx/html
#default command from nginx will run nginx, no need to specify start command
