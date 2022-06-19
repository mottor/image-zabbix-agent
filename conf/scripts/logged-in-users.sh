#!/bin/bash

who -a | grep -vE "(^LOGIN|system boot|run-level )" | awk '{print $1 " " $4 " " $8}'
