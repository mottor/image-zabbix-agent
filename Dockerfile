FROM zabbix/zabbix-agent:alpine-6.0-latest

USER root

RUN apk --update add mysql-client \
    && rm -rf /var/cache/apk/*

COPY conf/includes/ /etc/zabbix/zabbix_agentd.d
COPY conf/scripts/ /etc/zabbix/scripts
COPY conf/my-entrypoint.sh /usr/bin/my-entrypoint.sh

RUN sed -i "s~^exec~\0\nsource /usr/bin/my-entrypoint.sh~g" /usr/bin/docker-entrypoint.sh \
    && chown -R 1997 /etc/zabbix/zabbix_agentd.d \
    && chown -R 1997 /etc/zabbix/scripts

USER 1997