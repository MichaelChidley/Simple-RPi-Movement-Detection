#!/bin/bash

#Simple script to call the camera script every ten seconds
while [ true ]; do
	sleep 10
	sh "/media/External Backup/webcamlog/checkScript.sh"
done