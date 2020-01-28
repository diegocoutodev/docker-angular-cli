FROM node:alpine

LABEL maintainer="Diego do Couto <eng.coutodiego@gmail.com>"

ENV ANGULAR_UID=10001 \
    ANGULAR_GID=10001

ARG ANGULAR_VERSION='latest'

### Add user and group
RUN addgroup -S -g ${ANGULAR_GID} angular && adduser -S -G angular -u ${ANGULAR_UID} angular

### Install all dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache tzdata && \
    npm install -g @angular/cli@${ANGULAR_VERSION} && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /.cache && chown -Rf ${ANGULAR_UID}:${ANGULAR_GID} /.cache && \
    npm config set cache /.cache --global

ADD docker-entrypoint.sh /usr/bin/

RUN chmod a+x /usr/bin/docker-entrypoint.sh

WORKDIR /webapp

VOLUME [ "/webapp", "/.cache" ]

### Containers should not run as root as a good practice
USER ${ANGULAR_UID}

EXPOSE 4200

ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh" ]