#!/bin/bash

phits_out="phits.out"
if [ "" != "$1" ]; then
    phits_out=$1
fi
echo "PHITS output file: ${phits_out}"

start_time=`grep -A1 'Starting Date = ' ${phits_out}`
start_time=`echo ${start_time} | awk '{sub("h","",$8);sub("m","",$9);printf("%s %02d:%02d:%02d",$4,$8,$9,$10)}'`
ustart_time=`date --date="${start_time}" +%s`
stop_time=`grep -A1 'job termination date : ' ${phits_out}`
stop_time=`echo ${stop_time} | awk '{printf("%s %s",$5,$8)}'`
ustop_time=`date --date="${stop_time}" +%s`

duration_s=$((${ustop_time}-${ustart_time}))
duration_m=$((${duration_s}/60))
duration_h=$((${duration_m}/60))
duration_d=$((${duration_h}/24))


echo "Start time:      ${start_time}"
echo "Stop time:       ${stop_time}"
echo "Start unix time: ${ustart_time}"
echo "Stop unix time:  ${ustop_time}"
echo "Duration:"
echo "${duration_s} secs"
echo "${duration_m} mins"
echo "${duration_h} hrs"
echo "${duration_d} days"
