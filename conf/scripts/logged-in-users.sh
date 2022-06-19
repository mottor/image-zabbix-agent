#!/bin/bash

who -u | awk '{print $1 ": " $3 " " $4 " " $7}'
