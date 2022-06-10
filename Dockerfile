FROM zabbix/zabbix-agent2:alpine-6.0-latest

ENV ZBX_MYSQL_HOST=mysqlhost
ENV ZBX_MYSQL_USER=zabbix
ENV ZBX_MYSQL_PORT=3306
ENV ZBX_MYSQL_PASS=pass

USER root

RUN apk --update add mysql-client \
    && rm -rf /var/cache/apk/*

COPY conf/docker-entrypoint.sh /usr/bin
COPY conf/zabbix_agentd.d /etc/zabbix/zabbix_agentd.d
COPY conf/scripts /etc/zabbix/scripts
##COPY conf/my-entrypoint.sh /usr/bin/my-entrypoint.sh

##RUN sed -i "s~^exec.*~source /usr/bin/my-entrypoint.sh\n\0~g" /usr/bin/docker-entrypoint.sh \
RUN chmod +x /usr/bin/docker-entrypoint.sh \
    && chown 1997 -R /etc/zabbix/zabbix_agentd.d \
    && chown 1997 -R /etc/zabbix/scripts \
    && chmod 0755 -R /etc/zabbix/scripts
    ##&& echo '' > /var/lib/zabbix/.my.cnf && chown 1997:1997 /var/lib/zabbix/.my.cnf

HEALTHCHECK --interval=10s --timeout=3s --start-period=2s --retries=5 \
  CMD zabbix_agent2 -t agent.ping | grep -e '\[s|1\]' || exit 1

USER 1997