FROM alpine:latest
MAINTAINER Candido Tominaga <candido1212@gmail.com>
LABEL Description="Lightweight Postgresql Server docker container installed on Alpine Linux"


ENV LANG en_US.utf8
ENV PGHOME=/var/lib/postgresql
ENV PGDATA /var/lib/postgresql/data

RUN apk add --update postgresql postgresql-contrib && \
    mkdir -p ${PGHOME} ${PGDATA} && \
    chown -R postgres ${PGHOME} && \
    rm -rf /var/cache/apk/*

VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]