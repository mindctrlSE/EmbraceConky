#!/bin/bash
hour=`date +%H`
gMorning="Morning"
gAfternoon="Afternoon"
gEvening="Evening"
gNight="Night"
if [ $hour -lt 6 ]; then
  echo $gNight
elif [ $hour -lt 12 ]; then
  echo $gMorning
elif [ $hour -lt 18 ]; then
  echo $gAfternoon
else
  echo $gEvening
fi