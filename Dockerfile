FROM zabbix/zabbix-agent:alpine-6.0-latest

ENV ZBX_MYSQL_HOST=mysqlhost
ENV ZBX_MYSQL_USER=zabbix
ENV ZBX_MYSQL_PORT=3306
ENV ZBX_MYSQL_PASS=pass

USER root

RUN apk --update add mysql-client \
    && rm -rf /var/cache/apk/*

COPY conf/includes /etc/zabbix/zabbix_agentd.d
COPY conf/scripts /etc/zabbix/scripts
COPY conf/my-entrypoint.sh /usr/bin/my-entrypoint.sh

RUN sed -i "s~^exec.*~source /usr/bin/my-entrypoint.sh\n\0~g" /usr/bin/docker-entrypoint.sh \
    && chown -R 1997 /etc/zabbix/zabbix_agentd.d \
    && chown -R 1997 /etc/zabbix/scripts \
    && chmod 0755 -R /etc/zabbix/scripts

USER 1997