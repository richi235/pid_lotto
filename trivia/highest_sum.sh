#!/bin/bash

cut -d\  -f 2-8 lottozahlen | awk '
{
sum = $2 + $3 + $4 + $5 + $6 + $7
printf  "%s \t%3d\n", $0, sum
}
' | sort -rk 8
