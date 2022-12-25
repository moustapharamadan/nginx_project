#!/bin/bash

ROOTDIR=$(pwd)    #get current working directory
BUILDDIR=$ROOTDIR/build #build directory
NGINXDIR=$ROOTDIR/nginx #nginx directory
MODULE_NAME=$1

cd $NGINXDIR
./configure                       \
--with-debug                      \
--prefix=$BUILDDIR                \
--conf-path=conf/nginx.conf       \
--error-log-path=logs/error.log   \
--http-log-path=logs/access.log   \
--add-module=../$MODULE_NAME      
make
make install
cd ..