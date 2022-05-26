FROM zabbix/zabbix-agent:alpine-6.0-latest

USER root

RUN apk --update add mysql mysql-client \
    && rm -rf /var/cache/apk/* \

USER 1997