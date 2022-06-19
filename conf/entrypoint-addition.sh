#!/bin/bash

# создаем файл .my.cnf, чтобы zabbix-agent мог подключаться к MySQL
if [ "$ZBX_MYSQL_HOST" != "" ]; then
  MY_CNF_FILE=/var/lib/zabbix/.my.cnf

  echo "[client]" > $MY_CNF_FILE
  echo "host=${ZBX_MYSQL_HOST:-unset}" >> $MY_CNF_FILE
  echo "user=${ZBX_MYSQL_USER:-zabbix}" >> $MY_CNF_FILE
  echo "port=${ZBX_MYSQL_PORT:-3306}" >> $MY_CNF_FILE
  echo "password=${ZBX_MYSQL_PASS:-unset}" >> $MY_CNF_FILE

  chown 1997:1995 $MY_CNF_FILE
  chmod 0600 $MY_CNF_FILE
fi

# Выводим содержимое конфига, который получился в итоге патча с помощью docker-entrypoint.sh
echo "================================================="
echo "Final /etc/zabbix/zabbix_agent.conf content:"
echo " "
grep -Ev ^'(#|$)' /etc/zabbix/zabbix_agentd.conf
echo " "
echo "================================================="