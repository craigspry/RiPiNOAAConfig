#!/bin/bash

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture

#sudo timeout $6 rtl_fm -f ${2}M -s 60k -g 45 -p 55 -E deemp -F 9 - | sox -t raw -e signed - $3.wav rate 11025

sudo timeout $6 rtl_fm -f ${2}M -s 40k -r 11025 -g 40 -E deemp -F 9 - | sox -t raw -e signed -v 0.4 -c 1 -b 16 -r 11025 - $3.wav

PassStart=`expr $5 + 90`

if [ -e $3.wav ]
  then
    /usr/local/bin/wxmap -T "${1}" -H $4 -p 0 -l 0 -o $PassStart ${3}-map.png

    /usr/local/bin/wxtoimg -m ${3}-map.png -e ZA $3.wav $3.png
fi
