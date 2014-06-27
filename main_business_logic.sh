#!/bin/bash

# show a nice terminal UI to the User and let him select what to do next
whiptail --title "Enterprise PID Lotto" \
 --menu "\nWelcome to the Enterprise Business PID Lotto Suite. \n\nChoose what to do: \n\n" 30 78 16 \
 "1."         "    Alle deutschen Lotto-Ergebnisse aus dem Weltnetz herabladen." \
 "2."         "    Lotto Tipp aus PIDs erschaffen und Glueck versuchen" 2> /tmp/whiptail_choice 

answer=`cat /tmp/whiptail_choice`

if [ "$answer" = "1."  ]; then  # get lotto results from internet
    source ./get_lottozahlen.sh lottozahlen
    source ./adjust_output.sh lottozahlen


elif [ "$answer" = "2."  ]; then  # check for match
    source ./generate_pid_lottotips_unique.sh

    # lotto_tip_string="3 12 18 30 32 49"  # an actual winning tip string , here for testing

    # look for Hits without supernumber
    grep -E -e "^.{11}$lotto_tip_string" lottozahlen_ohne_SZ
    # look for Hits with supernumber
    grep -E -e "^.{11}$lotto_tip_string $lotto_supernumber" lottozahlen_mit_SZ
fi
