#!/bin/bash

#$1 list of columns
count_draws() {
  cut -d\  -f $1 < lottozahlen_only | while read LINE; do
  COUNT=$(./how_often_drawn.sh $LINE < lottozahlen_only | wc -l)
  if (($COUNT > 1)); then
      echo -e "${COUNT}x" $LINE
  fi
  done | sort -rn | uniq
}

#$1 which
print_draws() {
  if [ -f draws$1 ]; then
    echo "draws$1 already exists. using this file"
  else
    ./choose 6 $1 | while read perm; do
      if [ -n "$perm" ]; then
        perm=$(echo $perm | tr ' ' ',')
        echo $perm
        count_draws $perm > /tmp/draws$1
      fi
    done
    sort -rn < /tmp/draws$1 | uniq > draws$1
  fi
  echo "$1 draws" "(`wc -l < draws$1`)"
  head draws$1
}

print_draws 6
print_draws 5
print_draws 4
print_draws 3
print_draws 2

#6 draws
#if [ -f draws6 ]; then
#  echo "draws6 already exists. using this file"
#else
#  while read perm;do
#    perm=$(tr ' ' ',' $perm)
#    count_draws perm > draws6
#  done
#fi
#echo "6 draws"
#sort -rn < draws6 | uniq | head



#5 draws
#if [ -f draws5 ]; then
#  echo "draws5 already exists. using this file"
#else
  #count_draws '1,2,3,4,5' > draws5
  #count_draws '1,2,3,4,6' >> draws5
  #count_draws '1,2,3,5,6' >> draws5
  #count_draws '1,2,4,5,6' >> draws5
  #count_draws '1,3,4,5,6' >> draws5
  #count_draws '2,3,4,5,6' >> draws5
#fi
#echo "5 draws"
#sort -rn < draws5 | uniq | head


#4 draws
#if [ -f draws4 ]; then
#  echo "draws4 already exists. using this file"
#else
  #count_draws '1,2,3,4' > draws4
  #count_draws '1,2,3,5' >> draws4
  #count_draws '1,2,3,6' >> draws4
  #count_draws '1,2,4,5' >> draws4
  #count_draws '1,2,4,6' >> draws4
  #count_draws '1,2,5,6' >> draws4
  #count_draws '1,3,4,5' >> draws4
  #count_draws '1,3,4,6' >> draws4
  #count_draws '1,3,5,6' >> draws4
  #count_draws '1,4,5,6' >> draws4
  #count_draws '2,3,4,5' >> draws4
  #count_draws '2,3,4,6' >> draws4
  #count_draws '2,3,5,6' >> draws4
  #count_draws '2,4,5,6' >> draws4
  #count_draws '3,4,5,6' >> draws4
#fi
#echo "4 draws"
#sort -rn < draws4 | uniq | head

#3 draws
#if [ -f draws3 ]; then
#  echo "draws3 already exists. using this file"
#else
  #count_draws '1,2,3' > draws3
  #count_draws '1,2,4' >> draws3
  #count_draws '1,2,5' >> draws3
  #count_draws '1,2,6' >> draws3
  #count_draws '1,3,4' >> draws3
  #count_draws '1,3,5' >> draws3
  #count_draws '1,3,6' >> draws3
  #count_draws '1,4,5' >> draws3
  #count_draws '1,4,6' >> draws3
  #count_draws '1,5,6' >> draws3
  #count_draws '2,3,4' >> draws3
  #count_draws '2,3,5' >> draws3
  #count_draws '2,3,6' >> draws3
  #count_draws '2,4,5' >> draws3
  #count_draws '2,4,6' >> draws3
  #count_draws '2,5,6' >> draws3
  #count_draws '3,4,5' >> draws3
  #count_draws '3,4,6' >> draws3
  #count_draws '3,5,6' >> draws3
  #count_draws '4,5,6' >> draws3
#fi
#echo "3 draws"
#sort -rn < draws3 | uniq | head
