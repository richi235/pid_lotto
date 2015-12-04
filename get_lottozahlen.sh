#!/bin/bash

source config

page=http://www.lottozahlenonline.de/statistik/beide-spieltage/lottozahlen-archiv.php?j=

##create list of all needed years
##stdout=list of needed years
getYears() {
  seq -s ' ' 1955 $(date +"%Y")
}

##extract information inside divs
##stdin = all divs
##stdout= values inside divs
splitDivs() {
  sed -e 's|</div>[^<]*<div[^>]*>| |g' -e 's|<div[^<]*>||g' -e 's|</div>||g'
}

##extract divs containing desired information
##stdin = web page
##stdout=divs containing needed information
grepDivs() {
  grep -oE '<div class="zahlensuche_nr">[0-9]+</div><div class="zahlensuche_datum"[^<]*</div>(<div class="zahlensuche_zahl">[^<]*</div>){6}<div class="zahlensuche_zz">[^<]*</div>'
}

##delete escape sequences (they caused problems)
deleteEsc() {
  tr -d '\r' | tr -d '\n'
}

##concatinate Lottozahlen of all years
concatYears() {
  echo "--concatenating years"
  cat $(getYears) > all 
}

##add dummy Superzahl if not present (before 1991)
addDummySZ() {
  sed -e "s|\(.*\) $|\1 ${DummySZ}|"
}

##extract table from page into tmp file
##$1=year
extractLottoZahlen() {
  echo "--reading year ${1}"
  deleteEsc < $1.html | grepDivs | splitDivs | addDummySZ > $1
}

##load page from web into tmp file
##$1=year
loadPage() {
  echo "--loading ${page}${1}"
  wget $page$1 -qO ${1}.html
}

getLottoZahlen() {
  cur_dir=$(pwd)
  mkdir -p $tmp_folder
  cd $tmp_folder
  rm *

  years=$(getYears)
  for y in $years
  do
    loadPage $y
    extractLottoZahlen $y
  done
  concatYears

  cd $cur_dir
  cp $tmp_folder/all $1
}
getLottoZahlen $1

