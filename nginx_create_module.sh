#!/bin/bash

set -o nounset  #treat unset variables as error
set -o errexit  #causes the shell to exit immediately if a command returns a non-zero exit status

NGINX_MODULE_DIRECTORY=$1
NGINX_MODULE_NAME=$2
C_FILE_NAME="$NGINX_MODULE_NAME.c"
CONFIG_FILE="config"

if [ -d $NGINX_MODULE_DIRECTORY ]; then
    echo "Directory $NGINX_MODULE_DIRECTORY already exist"
    exit 1;
fi

mkdir $NGINX_MODULE_DIRECTORY > /dev/null 2>&1
cd $NGINX_MODULE_DIRECTORY

touch $CONFIG_FILE
echo "ngx_addon_name=$NGINX_MODULE_NAME" >> $CONFIG_FILE
echo "HTTP_MODULES=\"\$HTTP_MODULES $NGINX_MODULE_NAME\"" >> $CONFIG_FILE
echo "NGX_ADDON_SRCS=\"\$NGX_ADDON_SRCS \$ngx_addon_dir/$C_FILE_NAME\"" >> $CONFIG_FILE

touch $C_FILE_NAME
cat > $C_FILE_NAME << EOF
#include <nginx.h>
#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

ngx_module_t $NGINX_MODULE_NAME;
EOF