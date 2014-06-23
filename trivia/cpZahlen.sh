#!/bin/bash

#cat ../lottozahlen | head -n 100 > lottozahlen
cp ../lottozahlen lottozahlen
cut -d\  -f 3-8 < lottozahlen > lottozahlen_only
