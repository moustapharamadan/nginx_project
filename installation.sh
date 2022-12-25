#!/bin/bash

set -o nounset  #treat unset variables as error
set -o errexit  #causes the shell to exit immediately if a command returns a non-zero exit status

ROOTDIR=$(pwd)    #get current working directory
BUILDDIR=$ROOTDIR/build #build directory
NGINXDIR=$ROOTDIR/nginx #nginx directory
NGINX_VERSION=$1
NGINX_ZIPFILE_NAME="nginx.tar.gz"

clean_directories () 
{
    rm -rf $BUILDDIR $NGINXDIR
}

setup_local_directories()   #create build and nginx directories
{
    if [ ! -d $BUILDDIR ]; then
        mkdir $BUILDDIR > /dev/null 2>&1
    fi

    if [ ! -d $NGINXDIR ]; then
        mkdir $NGINXDIR > /dev/null 2>&1
    fi
}

install_nginx()
{
    if [ -z "$(ls -A $NGINXDIR)" ]; then #check if nginx directory is empty
        #download Nginx version and rename the zip file to nginx.tar.gz"
        curl -s -L -o $NGINX_ZIPFILE_NAME "http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz"
        #extract downloaded zip under nginx directory
        tar xzf "$NGINX_ZIPFILE_NAME" -C $NGINXDIR --strip-components=1
        #clean up the build directory
        rm -rf $BUILDDIR/*
        #enter nginx directory
        cd $NGINXDIR
        #configure, compile and install Nginx source code
        ./configure                           \
            --with-debug                      \
            --prefix=$BUILDDIR                \
            --conf-path=conf/nginx.conf       \
            --error-log-path=logs/error.log   \
            --http-log-path=logs/access.log
        make
        make install
        cd ..
        #delete downloaded zip file
        rm -f $NGINX_ZIPFILE_NAME
    else
        echo "$NGINXDIR is not empty"
    fi
}

if [ ! -d $NGINXDIR ]; then
    mkdir $NGINXDIR > /dev/null 2>&1
fi

if [[ "$#" -eq 2 ]]; then
    if [[ "$2" == "clean" ]]; then
        clean_directories
    fi
fi
setup_local_directories
install_nginx