#!/bin/bash

cd src
#javac -d ../bin servers/*.java
mkdir ../bin 2> /dev/null

# compile server
javac -target 1.7 -source 1.7 -d ../bin ./*.java 
if [ $? -ne 0 ]
then
    echo "Fail to compile source code of tcp server"
    exit $?
fi

cd ..
mkdir mlab 2> /dev/null

# generate jars for server
cd bin
echo "Main-Class: MNEPAcceptConnection" > manifest
jar cvfm MITATE.jar manifest *.class
mv MITATE.jar ../mlab

rm manifest
echo "Successful compile the UDP server code."
cd ..