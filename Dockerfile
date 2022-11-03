#syntax=docker/dockerfile:1

FROM alpine AS clone

WORKDIR /app

RUN apk add --no-cache openssh-client git

RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh,id=ssh_simpleWeb,required git clone git@github.com:persi52/FullStackProgramming.git

FROM node:alpine 

COPY --from=clone /app/FullStackProgramming /app

WORKDIR /app

RUN npm install

EXPOSE 8080

CMD ["npm", "start"]
