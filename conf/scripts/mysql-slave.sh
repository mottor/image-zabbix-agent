#!/usr/bin/env bash

ITEM="$1"
mysql --vertical -e "SHOW SLAVE STATUS" | grep "$ITEM:" | awk -F ':' '{print $2}' | awk '{$1=$1};1'
