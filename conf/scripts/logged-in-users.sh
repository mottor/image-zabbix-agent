#!/bin/bash

who -a | grep -vE "(^LOGIN|^pts/\d+|system boot|run-level )" | awk '{print $1 " " $4 " " $8}'
