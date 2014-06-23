#!/bin/bash

awk '
BEGIN {
total       = 0
even_odd[0] = 0
even_odd[1] = 0
}
{
total+=6
even_odd[$1 % 2]++
even_odd[$2 % 2]++
even_odd[$3 % 2]++
even_odd[$4 % 2]++
even_odd[$5 % 2]++
even_odd[$6 % 2]++
}
END {
if(even_odd[0] > even_odd[1]) {
    difference = even_odd[0] - even_odd[1]
} else {
    difference = even_odd[1] - even_odd[0]
}
even_percent       = even_odd[0] / total * 100
odd_percent        = even_odd[1] / total * 100
difference_percent = difference / total * 100
printf "total      %d\n",total
printf "even       %d(%.1f%%)\n",even_odd[0],even_percent
printf "odd        %d(%.1f%%)\n",even_odd[1],odd_percent
printf "difference %d(%.1f%%)\n",difference,difference_percent
}
' < lottozahlen_only

