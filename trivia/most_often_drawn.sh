#!/bin/bash

#$1 list of columns
count_draws() {
  cut -d\  -f $1 < lottozahlen_only | while read LINE; do
  COUNT=$(./how_often_drawn.sh $LINE < lottozahlen_only | wc -l)
  #if (($COUNT > 1)); then
      echo -e "${COUNT}x" $LINE
  #fi
  done | sort -rn | uniq
}

#$1 which
print_draws() {
  if [ -f draws$1 ]; then
    echo "draws$1 already exists. using this file"
  else
    echo "" > /tmp/draws$1
    ./choose 6 $1 | while read perm; do
      if [ -n "$perm" ]; then
        perm=$(echo $perm | tr ' ' ',')
        echo $perm
        count_draws $perm >> /tmp/draws$1
      fi
    done
    sort -rn < /tmp/draws$1 | uniq | sed '/^$/d' > draws$1
  fi
  echo "$1 draws" "(`wc -l < draws$1`)"
  head draws$1
}

print_draws 6
print_draws 5
print_draws 4
print_draws 3
print_draws 2

