#!/bin/bash

if [ "$ZBX_MYSQL_HOST" != "" ]; then
  MY_CNF_FILE=/var/lib/zabbix/.my.cnf

  echo "[client]" > $MY_CNF_FILE
  echo "host=${ZBX_MYSQL_HOST}" >> $MY_CNF_FILE
  echo "user=${ZBX_MYSQL_USER:-zabbix}" >> $MY_CNF_FILE
  echo "port=${ZBX_MYSQL_PORT:-3306}" >> $MY_CNF_FILE
  echo "password=${ZBX_MYSQL_PASS}" >> $MY_CNF_FILE

  chown 1997:1997 $MY_CNF_FILE
  chmod 0600 $MY_CNF_FILE
fi
