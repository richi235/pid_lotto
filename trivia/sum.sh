#!/bin/bash

tr -d 'x' < draws$1 | awk '
BEGIN {
  sum=0
}
{
  sum += $1
  #print $1
}
END {
  print sum
}
'

