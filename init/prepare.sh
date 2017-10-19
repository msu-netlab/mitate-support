#!/bin/bash

set -x
set -e

REQUIRED_PKGS="cronie crontabs yum-cron"

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

yum install -y $REQUIRED_PKGS

pushd $SOURCE_DIR/MITATE/MeasurementServer
    bash compile.sh
popd

mkdir -p $BUILD_DIR/MITATE
cp -r $SOURCE_DIR/MITATE/MeasurementServer/mlab/*  $BUILD_DIR/MITATE/
