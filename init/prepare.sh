#!/bin/bash

set -x
set -e

export SOURCE_DIR=~/mlab/mitate-support
export BUILD_DIR=~/mlab/build

if [ -z "$SOURCE_DIR" ] ; then
    echo "Expected SOURCE_DIR in environment"
    exit 1
fi
if [ -z "$BUILD_DIR" ] ; then
    echo "Expected BUILD_DIR in environment"
    exit 1
fi

if test -d $BUILD_DIR ; then
    rm -rf $BUILD_DIR/*
fi

pushd $SOURCE_DIR/MITATE/MeasurementServer
    ./compile.sh
popd

mkdir -p $BUILD_DIR/MITATE
cp -r $SOURCE_DIR/MITATE/MeasurementServer/mlab/*  $BUILD_DIR/MITATE/
install -D -m 0755 $SOURCE_DIR/MITATE/MeasurementServer/initialize.sh $BUILD_DIR/init/initialize.sh
install -D -m 0755 $SOURCE_DIR/MITATE/MeasurementServer/start.sh $BUILD_DIR/init/start.sh
install -D -m 0755 $SOURCE_DIR/MITATE/MeasurementServer/stop.sh $BUILD_DIR/init/stop.sh