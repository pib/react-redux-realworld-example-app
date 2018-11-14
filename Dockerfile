FROM node:alpine as base

FROM base as builder
WORKDIR /app
COPY . /app
RUN npm install --verbose
RUN npm run build --verbose


FROM node:slim
WORKDIR /app
RUN npm install -g serve --verbose
COPY --from=builder /app/build /app

ENTRYPOINT ["serve", "-n", "-s", "-l", "tcp://0.0.0.0:80", "/app"]
