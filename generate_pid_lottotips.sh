#!/bin/bash

pids=(`ps ax  --no-headers  -o pid`)
# echo -e "Hello Sir, currently you have ${#pids[*]} Processes on your System\n"

# concatenate all pids
concatenation_of_pids=

for pid in ${pids[*]} ; do
    concatenation_of_pids+=$pid
done    

hashed_pids=`echo $concatenation_of_pids | sha512sum`

# remove the last 3 characters since they are " - " and therefore useless
hashed_pids=${hashed_pids:0:-3}

# Make all characters (hexadecimal A-F) uppercase
hashed_pids=${hashed_pids^^}

# convert from base 16 to decimal
hashed_pids=`echo "ibase=16 ; $hashed_pids" | bc`


# get lotto tip numbers from hash string
#      lotto numbers are from 1-49 therefore the
#      modulo operator and the +1
#      the 10# is necessary to avaid bash thinks that numbers like 08 are octal 
#          and therefore throws an error because of, "octal number to big"
lotto_tip_1=$(( (10#${hashed_pids:0:2} % 49) + 1 ))
lotto_tip_2=$(( (10#${hashed_pids:2:2} % 49) + 1 ))
lotto_tip_3=$(( (10#${hashed_pids:4:2} % 49) + 1 ))
lotto_tip_4=$(( (10#${hashed_pids:6:2} % 49) + 1 ))
lotto_tip_5=$(( (10#${hashed_pids:8:2} % 49) + 1 ))
lotto_tip_6=$(( (10#${hashed_pids:10:2} % 49) + 1 ))

# superzahl in german lotteria
lotto_supernumber=${hashed_pids:12:1}


#echo $lotto_tip_1
#echo $lotto_tip_2
#echo $lotto_tip_3
#echo $lotto_tip_4
#echo $lotto_tip_5
#echo $lotto_tip_6
#echo $lotto_supernumber
