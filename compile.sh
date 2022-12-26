#!/bin/bash

ROOTDIR=$(pwd)    #get current working directory
BUILDDIR=$ROOTDIR/build #build directory
NGINXDIR=$ROOTDIR/nginx #nginx directory

cd $NGINXDIR
if [[ "$#" -eq 1 ]]; then
    MODULE_NAME=$1
    ./configure                       \
    --with-debug                      \
    --prefix=$BUILDDIR                \
    --conf-path=conf/nginx.conf       \
    --error-log-path=logs/error.log   \
    --http-log-path=logs/access.log   \
    --add-module=../$MODULE_NAME     
else
    ./configure                       \
    --with-debug                      \
    --prefix=$BUILDDIR                \
    --conf-path=conf/nginx.conf       \
    --error-log-path=logs/error.log   \
    --http-log-path=logs/access.log   
fi
 
make
make install
cd ..