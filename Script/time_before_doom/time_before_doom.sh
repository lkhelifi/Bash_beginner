#!/bin/bash 

curl -o res $1;

lat=$(cut -d'"' -f 14 res);
lng=$(cut -d'"' -f 10 res);
dist=$(cut -d'"' -f 18 res);
speed=$(cut -d'"' -f 22 res);

rem_time=$((($dist*1000)/$speed));

days=$(($rem_time/86400)) #2 jours
hours=$((($rem_time%86400)/3600)) 
minutes=$((($rem_time%3600)/60))
seconds=$((($rem_time%60)))

echo "The Angry Moon is located at lat: $lat, lng: $lng.
It is $distkm away from us, but it is going to fall at a speed of $speed.
We have exactly $days days, $hours hours, $minutes minutes and $seconds seconds to react."
