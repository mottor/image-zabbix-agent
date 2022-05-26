FROM zabbix/zabbix-agent:alpine-6.0-latest

USER root

RUN apk --update add mysql-client \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/zabbix/zabbix_agentd.d

USER 1997