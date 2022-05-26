#!/bin/bash
# скрипт проверяет возможность записи папку
#
# был случай с Казахстанским фронтендом, что перестала работать синхронизация syncthing
# рестарт через docker-compose выдавал INTERNAL ERROR: cannot create temporary directory!
# а Ansible выдавал ошибку FileNotFoundError: [Errno 2] No usable temporary directory found in ['/tmp', '/var/tmp', '/usr/tmp', '/home/bakulin']
#
# решилось это только перезагрузкой сервера, пинанием поддержки. Они в итоге сделали перезагрузку и поправили ФС
#

set -euo pipefail

DIR=${1:-/tmp}
DATE=$(date '+%s')
FILE=$DIR/check-readonly-$DATE

touch $FILE && { rm $FILE; echo "1"; } || echo "0"
