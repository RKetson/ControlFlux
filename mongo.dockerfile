FROM alpine:3.20.2

RUN apk update
RUN apk add --no-cache curl ca-certificates openssl
RUN mkdir -p /etc/apk/repositories.d
RUN mkdir -p /etc/apk/keys
RUN echo "http://repo.mongodb.org/apk/alpine/v3.20/main" > /etc/apk/repositories.d/mongodb-org-7.0.repo
RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc | apk add --no-cache --allow-untrusted -U /etc/apk/keys/

RUN apk update
RUN apk add --no-cache mongodb
EXPOSE 27017
VOLUME /data/db
CMD ["mongod", "--bind_ip", "0.0.0.0"]