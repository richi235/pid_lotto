#!/bin/bash

cut -d\  -f 3-8 ../lottozahlen | awk '
{counts[$1]++;counts[$2]++;counts[$3]++;counts[$4]++;counts[$5]++;counts[$6]++}
END{
for(i=1; i<=49; i++){
   printf "%2d: %3d\n",i,counts[i] 
}
}' | sort -rk 2
