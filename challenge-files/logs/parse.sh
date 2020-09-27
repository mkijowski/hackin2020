#!/bin/bash

FILENAME=$1

cat $FILENAME | tr ' ' '.' | while read l; do echo "$(echo $l | wc) 1-p" | /usr/bin/dc; done | tr '\n' ' ' >> first.flag

cat $FILENAME | tr ' ' '.' | while read l; do echo "$(echo $l | wc) 1-p" | /usr/bin/dc; done | tr '\n' ' ' | cut -d' ' -f81-107 >> second.time

cat $FILENAME | tr ' ' '.' | while read l; do echo "$(echo $l | wc) 1-p" | /usr/bin/dc; done | tr '\n' ' ' | cut -d' ' -f111-141 >> third

