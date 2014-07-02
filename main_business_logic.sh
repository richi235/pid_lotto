#!/bin/bash

# show a nice terminal UI to the User and let him select what to do next
whiptail --title "Enterprise PID Lotto" \
   --menu "\nWelcome to the Enterprise Business PID Lotto Suite. \n\nChoose what to do: \n\n" 25 78 16 \
    "1."         "    Alle deutschen Lotto-Ergebnisse aus dem Weltnetz herabladen." \
    "2."         "    Lotto Tipp aus PIDs erschaffen und Glueck versuchen" 2> /tmp/whiptail_choice 

user_choice=`cat /tmp/whiptail_choice`


# Do Things according to user selection
if [ "$user_choice" = "1."  ]; then  # get lotto results from internet
    source ./get_lottozahlen.sh lottozahlen
    source ./adjust_output.sh lottozahlen

elif [ "$user_choice" = "2."  ]; then  # check for match
    source ./generate_pid_lottotips.sh
#     lotto_tip_string="3 12 18 30 32 49"  # an actual winning tip string , without Supernumber, here for testing 
#     lotto_tip_string="1 5 16 19 24 48" # an actual winning tip string , with Supernumber, here for testing 
#     lotto_supernumber="5"

    # check for Hits without supernumber
    grep -E -e "^.{11}$lotto_tip_string" lottozahlen_ohne_SZ > /tmp/winning_time 
    grep_return_value=$?
    winning_time=`cat /tmp/winning_time`
    winning_time=${winning_time:0:10}
    #echo $winning_time

    # Display congratulation message if grep matches something
    if (($grep_return_value==0)) ; then 
        whiptail --title "Gewonnen !1!!!1!!! " \
                 --msgbox "Herzlichen Glueckwunsch Sie haben mit den Lottozahlen \n\n    $lotto_tip_string \n\n am $winning_time gewonnen. \n\nAbzaehlbar unendlicher Reichtum erwartet Sie!" 25 78
        exit
    fi  # check for matches with supernumber only if no match happened:
        
       


    # check for Hits with supernumber
    grep -E -e "^.{11}$lotto_tip_string $lotto_supernumber" lottozahlen_mit_SZ > /tmp/winning_time
    grep_return_value=$?
    winning_time=`cat /tmp/winning_time`
    winning_time=${winning_time:0:10}
    #echo $winning_time

    if (($grep_return_value==0)) ; then 
        whiptail --title "Gewonnen !1!!!1!!! " \
                 --msgbox "Herzlichen Glueckwunsch Sie haben mit den Lottozahlen \n\n    $lotto_tip_string und Superzahl: $lotto_supernumber  \n\n am $winning_time gewonnen. \n\nUeberabzaehlbar unendlicher Reichtum erwartet Sie!" 25 78
        exit
    elif (($grep_return_value == 1)) ; then
        whiptail --title "Verloren !1!!!1!!!" \
                 --msgbox "Sie haben eine Niete gezogen. Ihre Zahlen waren \n\n    $lotto_tip_string mit Superzahl: $lotto_supernumber \n\n." 25 78
        exit
    fi

fi
