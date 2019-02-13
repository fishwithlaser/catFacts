#!/bin/bash
#
# 	04-19-2018 Catfacts shell script
# 	created by Thomas kosciuch
# 	thomas@kosciuch.ca
#
#
#	Finds the list of catfacts
filePath="toSend.txt"
catFact=$(cat "$filePath")
toSend=$(sed -n "1p" < $filePath) 

#	finds the list of addresses to send to (note this is after the pause!)
iPath="imessage.txt"
phonePath="numbers.txt"

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
