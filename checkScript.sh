#!/bin/bash

#Get the current date/time
DATE=`date +%Y-%m-%d-%H-%M-%S`

#Find the previously created file in the current directory
OLD_FILE=`find . -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "`

#Get the size of the previously created file
OLD_FILE_SIZE=`stat -c %s $OLD_FILE`

#Call fswebcam to take a picture using the webcam and store it with the date/time appended to the filename
fswebcam -d /dev/video0  -r 640x480 test-$DATE.jpeg

#Find the new image file size
CURRENT_FILE_SIZE=`stat -c %s test-$DATE.jpeg`

#Calculate the difference between the previously created file and the new file
FILE_DIFFERENCE=`expr $CURRENT_FILE_SIZE - $OLD_FILE_SIZE`

#Email address to notify
EMAIL=""

#If the file size difference is greater than 5kb, notify email address
if [ "$FILE_DIFFERENCE" -gt 5000 ]
then
		MESSAGE="Movement in room detected"
		echo "$MESSAGE" | mutt -s "MOVEMENT DETECTED @ $DATE" -a test-$DATE.jpeg -- $EMAIL
fi
