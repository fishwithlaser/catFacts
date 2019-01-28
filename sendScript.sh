#!/bin/bash

#
# 	04-19-2018 Catfacts shell script
# 	created by Thomas kosciuch
# 	thomas@kosciuch.ca
#

#	Infinite loop (start)
while : ; do 

#	Finds the list of catfacts
filePath="/Users/thomaskosciuch/Documents/02_projects/catFacts/catFacts.txt"
catFact=$(cat "$filePath")

#	For-loop timer for randomly recurring cat facts
pauseLength=$(($(od -vAn -N4 -tu4 </dev/urandom)%172800))
#useful times: 28800 is 8 hours #172800 is one day
 
currentTime=$(date +%s)
futureTime=$[$currentTime + $pauseLength]
sendTime=$(date -r $futureTime '+%m/%d/%Y:%H:%M:%S')
echo "will send catFact at $sendTime"   
sleep $pauseLength

#	finds the list of addresses to send to (note this is after the pause!)
iPath="/Users/thomaskosciuch/Documents/02_projects/catFacts/imessage.txt"
phonePath="/Users/thomaskosciuch/Documents/02_projects/catFacts/numbers.txt"

#	Selects random fact out of fact list
factLength=$(wc -l $filePath)
factNum=$$(($(od -vAn -N4 -tu4 </dev/urandom)%139))
toSend=$(sed -n "${factNum}p" < $filePath)
#echo "$toSend" #previews catFact

#	sends fact to sms people
while IFS= read -r num; do
echo $num
osascript /Users/thomaskosciuch/Documents/02_projects/catFacts/catFactsSMS.applescript "$num" "$toSend"
done < "$phonePath"

#	sends fact to iMessages people
while IFS= read -r num; do
echo $num
osascript /Users/thomaskosciuch/Documents/02_projects/catFacts/catFactsImessage.applescript "$num" "$toSend"
done < "$iPath"

#	tells you the time the fact was sent
echo $(date +"%r")

# finishes infinite loop
done &