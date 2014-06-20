#!/bin/bash

source config

page=http://www.lottozahlenonline.de/statistik/beide-spieltage/lottozahlen-archiv.php?j=

##create list of all needed years
##stdout=list of needed years
function getYears {
  echo $(seq 1955 $(date +"%Y"))
}

##extract information inside divs
##stdin = all divs
##stdout= values inside divs
function splitDivs {
  sed -e 's|</div>[^<]*<div[^>]*>| |g' -e 's|<div[^<]*>||g' -e 's|</div>||g'
}

##extract divs containing desired information
##stdin = web page
##stdout=divs containing needed information
function grepDivs {
  grep -oP '<div class="zahlensuche_nr">[0-9]+</div><div class="zahlensuche_datum"[^<]*</div>(<div class="zahlensuche_zahl">[^<]*</div>){6}<div class="zahlensuche_zz">[^<]*</div>'
}

##delete escape sequences (they caused problems)
function deleteEsc {
  tr -d '\r' | tr -d '\n'
}

##concatinate Lottozahlen of all years
function concatYears {
  echo "--concatenating years"
  years=$(getYears)
  cat $(getYears) > all 
}

##add dummy Superzahl if not present (before 1991)
function addDummySZ {
  sed -e "s|\(.*\) $|\1 ${DummySZ}|"
}

##extract table from page into tmp file
##$1=year
function extractLottoZahlen {
  echo "--reading year ${1}"
  cat $1.html | deleteEsc | grepDivs | splitDivs | addDummySZ > $1
}

##load page from web into tmp file
##$1=year
function loadPage {
  echo "--loading ${page}${1}"
  wget $page$1 -qO ${1}.html
}

function getLottoZahlen {
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

