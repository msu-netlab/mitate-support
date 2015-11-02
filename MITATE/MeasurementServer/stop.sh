#!/bin/bash
#this script needs to be run from the current directory
exec >> /var/log/MITATE 2>&1
echo "####### Running /home/montana_1/init/stop.sh at `date` ########"

for i in MITATE
do
	echo "stopping $i"
	ps aux | grep "$i.jar" | awk '{system("kill -9 " $2);}'
done