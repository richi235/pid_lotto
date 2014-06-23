#!/bin/bash

echo "six sequences"
for((i=1;i<=49;i++))
do
search=" $i `expr $i + 1` `expr $i + 2` `expr $i + 3` `expr $i + 4` `expr $i + 5`"
grep --colo=auto "$search" lottozahlen
done

echo "five sequences"
for((i=1;i<=49;i++))
do
search=" $i `expr $i + 1` `expr $i + 2` `expr $i + 3` `expr $i + 4`"
grep --color=auto "$search" lottozahlen
done

echo "four sequences"
for((i=1;i<=49;i++))
do
search=" $i `expr $i + 1` `expr $i + 2` `expr $i + 3`"
grep --color=auto "$search" lottozahlen
done
