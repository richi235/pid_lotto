#!/bin/bash

#filter all lines that contain all parameters
if test $# -gt 0; then
    TMP1=$1
    shift
    grep -w "$TMP1" | ./how_often_drawn.sh $@
else
    cat
fi

