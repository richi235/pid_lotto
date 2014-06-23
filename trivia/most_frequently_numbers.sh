#!/bin/bash

awk '
BEGIN {
for(i=1;i<=49;i++) {
    counts[i] = 0
}
}
{counts[$1]++;counts[$2]++;counts[$3]++;counts[$4]++;counts[$5]++;counts[$6]++}
END{
for(i=1; i<=49; i++){
   printf "%2d: %3d\n",i,counts[i] 
}
}' < lottozahlen_only | sort -rk 2
