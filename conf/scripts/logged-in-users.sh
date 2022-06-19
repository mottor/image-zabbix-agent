#!/bin/bash

who -a | grep -vE "(^LOGIN|system boot|run-level |pts/\d+)"
