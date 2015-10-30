#!/bin/bash

exec >> /var/log/MITATE 2>&1
echo "####### Running /home/montana_1/init/start.sh at `date` ########"

cd /home/montana_1/MITATE

services="MITATE:32165:tcp"

start() {
        echo "Attempting to start $1 ..."
        java -Xmx128M -jar $1.jar &
        sleep 2
        jarpid=$!
}

for service in $services
do
        IFS=':' read jar port proto <<< "$service"
        start $jar
        started=no
        for i in {1..5}; do
                if [ -n $jarpid ] && ps $jarpid &> /dev/null ; then
                        if nc -z localhost $port >> /dev/null; then
                                started=yes
                                echo "${jar} successfully started and listening on port ${port}."
                                break
                        else
                                echo "${jar} not listening on port ${port}.  Sleeping for ${i}s before trying again."
                                sleep $i
                        fi
                else
                        echo "${jar} seeems to have crashed."
                        start $jar
                fi
        done

        if [ $started == "no" ]; then
                echo "${jar} failed to start for some reason."
                exit 1
        fi
done