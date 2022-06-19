#FROM zabbix/zabbix-agent:alpine-6.0-latest
FROM zabbix/zabbix-agent2:alpine-6.0-latest

ENV ZBX_MYSQL_HOST=mysqlhost
ENV ZBX_MYSQL_USER=zabbix
ENV ZBX_MYSQL_PORT=3306
ENV ZBX_MYSQL_PASS=pass
ENV ADD_GATEWAY_AS_SERVER=no

USER root

RUN apk --update add \
    mysql-client \
    busybox-extras \
    && rm -rf /var/cache/apk/*

COPY conf/docker-entrypoint.sh /usr/bin
COPY conf/zabbix_agentd.d /etc/zabbix/zabbix_agentd.d
COPY conf/scripts /etc/zabbix/scripts
###COPY conf/entrypoint-addition.sh /usr/bin/entrypoint-addition.sh

# пачтинг docker-entrypoint.sh
# этой командой мы добавляем source <наша entrypoint>, чтобы добавить наш код в docker-entrypoint офф контейнера
#RUN sed -i "s~^exec.*~source /usr/bin/entrypoint-addition.sh\n\0~g" /usr/bin/docker-entrypoint.sh \
#    sed -i "s~^ZABBIX_ETC_DIR=~\0\nif [ "${ADD_GATEWAY_AS_SERVER}" == "y" ]; then GATEWAY_IP=",`/sbin/ip route | awk \"/default/ { print $3 }\"`"~g' /usr/bin/docker-entrypoint.sh

RUN chmod +x /usr/bin/docker-entrypoint.sh \
    && chown 1997 -R /etc/zabbix/zabbix_agentd.d \
    && chown 1997 -R /etc/zabbix/scripts \
    && chmod 0755 -R /etc/zabbix/scripts
    ##&& echo '' > /var/lib/zabbix/.my.cnf && chown 1997:1997 /var/lib/zabbix/.my.cnf

#HEALTHCHECK --interval=10s --timeout=3s --start-period=1s --retries=5 CMD zabbix_agentd -t agent.ping | grep -e '\[u|1\]' || exit 1
HEALTHCHECK --interval=10s --timeout=3s --start-period=1s --retries=5 CMD zabbix_agent2 -t agent.ping | grep -e '\[s|1\]' || exit 1

USER 1997