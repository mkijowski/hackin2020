#!/bin/bash

cat file | tr ' ' '.' | while read l; do echo "$(echo $l | wc) 1-p" | dc; done | tr '\n' ' '

