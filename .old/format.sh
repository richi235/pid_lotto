#!/bin/bash

function richi {
  awk '{
    printf("%s;%02d,%02d,%02d,%02d,%02d,%02d,%d\n",$2,$3,$4,$5,$6,$7,$8,$9);
  }'
}

function table {
  awk '{
    printf("%03d %s %02d %02d %02d %02d %02d %02d %d\n",$1,$2,$3,$4,$5,$6,$7,$8,$9);
  }'
}

table < $1 > $2

