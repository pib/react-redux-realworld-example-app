FROM node:alpine as base

FROM base as builder
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build


FROM node:slim
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /app/build /app

ENTRYPOINT ["serve", "-n", "-s", "-l", "tcp://0.0.0.0:80", "/app"]
