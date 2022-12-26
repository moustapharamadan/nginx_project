# nginx_project

## 1- installation.sh
This script is responsible for downloading, extracting, building, and installing the nginx source code.<br>
To run the script you need:
- Add execute permission on script: chmod +x installation.sh
- Pass the first argument for the nginx version: ex 1.22.1
- Pass the optional second argument to clean up existing synced directories: clean
- **./installation.sh \<version>** or **./installation.sh \<version> clean**

Example: **./installation.sh 1.22.1** or **./installation.sh 1.22.1 clean**

## 2- nginx_create_module.sh
This script is responsible for creating a new custom nginx module<br>
To run the script you need:
- Add execute permission on script: chmod +x nginx_create_module.sh
- Pass the first argument for the nginx module directory name
- Pass the second argument for the nginx module name: clean
- ./nginx_create_module.sh \<module directory name> \<module name>

Example: **./nginx_create_module.sh myModule ngx_http_auth_token_module**

## 3- compile.sh
This script is responsible for compiling nginx source and any additional custom module<br>
To run the script you need:
- Add execute permission on script: chmod +x compile.sh
- **./compile.sh** or **./compile.sh \<module directory name>**

Example: **./compile.sh** or **./compile.sh myModule**
