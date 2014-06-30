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
#      the 10# is necessary to avoid bash thinks that numbers like 08 are octal 
#          and therefore throws an error because of, "octal number to big"
ball_to_pick_1=$(( (10#${hashed_pids:0:2} % 49) + 1 ))
ball_to_pick_2=$(( (10#${hashed_pids:2:2} % 48) + 1 ))
ball_to_pick_3=$(( (10#${hashed_pids:4:2} % 47) + 1 ))
ball_to_pick_4=$(( (10#${hashed_pids:6:2} % 46) + 1 ))
ball_to_pick_5=$(( (10#${hashed_pids:8:2} % 45) + 1 ))
ball_to_pick_6=$(( (10#${hashed_pids:10:2} % 44) + 1 ))

# superzahl in german lotteria
lotto_supernumber=${hashed_pids:12:1}

# atm it's possible that 2 tip numbers are the same, the following code avoids this
lotto_balls=()

for ((i=1 ; i<50 ; i++ )) ; do
    lotto_balls[$i]=$i 
done    

# pick lotto ball 1:
lotto_ball_1=${lotto_balls[$ball_to_pick_1]}
lotto_balls[$ball_to_pick_1]=${lotto_balls[49]}
unset lotto_balls[49]

# pick lotto ball 2:
lotto_ball_2=${lotto_balls[$ball_to_pick_2]}
lotto_balls[$ball_to_pick_2]=${lotto_balls[48]}
unset lotto_balls[48]

# pick lotto ball 3:
lotto_ball_3=${lotto_balls[$ball_to_pick_3]}
lotto_balls[$ball_to_pick_3]=${lotto_balls[47]}
unset lotto_balls[47]

# pick lotto ball 4:
lotto_ball_4=${lotto_balls[$ball_to_pick_4]}
lotto_balls[$ball_to_pick_4]=${lotto_balls[46]}
unset lotto_balls[46]

# pick lotto ball 5:
lotto_ball_5=${lotto_balls[$ball_to_pick_5]}
lotto_balls[$ball_to_pick_5]=${lotto_balls[45]}
unset lotto_balls[45]

# pick lotto ball 6:
lotto_ball_6=${lotto_balls[$ball_to_pick_6]}
lotto_balls[$ball_to_pick_6]=${lotto_balls[44]}
unset lotto_balls[44]

# generate one string of sorted numbers from the 6 integers
lotto_tip_string=`echo -e "$lotto_ball_1\n$lotto_ball_2\n$lotto_ball_3\n$lotto_ball_4\n$lotto_ball_5\n$lotto_ball_6" | sort -n`
lotto_tip_string=`echo $lotto_tip_string | sed 's:\n: :'`



# echo $lotto_tip_string
# echo "Supernumber:"$lotto_supernumber
