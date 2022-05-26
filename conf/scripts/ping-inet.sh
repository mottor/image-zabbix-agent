#!/bin/bash
#
# скрипт проверяет доступность интернета для данного хоста
#
TEST_HOST=vk.com
TIMEOUT=5

set -euo pipefail
ping -c 1 -w $TIMEOUT $TEST_HOST >> /dev/null 2>/dev/null && echo '1' || echo '0'
