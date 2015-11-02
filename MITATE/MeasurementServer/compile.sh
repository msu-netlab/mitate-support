#!/bin/bash

cd src
mkdir ../bin 2> /dev/null

# compile server
javac -target 1.7 -source 1.7 -d ../bin ./*.java 
if [ $? -ne 0 ]
then
    echo "Failed to compile the server code."
    exit $?
fi

cp -R com/mysql ../bin/com/mysql

cd ..
mkdir mlab 2> /dev/null

# generate jars for server
#cd bin
echo "Main-Class: MNEPAcceptConnection" > manifest
jar cvfm ./mlab/MITATE.jar manifest -C bin/ .

rm manifest
echo "Successfuly compiled the server code."
cd ..