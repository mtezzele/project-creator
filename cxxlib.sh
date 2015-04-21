#!/bin/bash

# Authors: Marco Tezzele and Mauro Bardelloni
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $AUTHOR is the author of the project
# $PROJECT_NAME is the name of the project
# $CLASSES is the name of the classes (in lower case)

source "include/utilities.sh"
source "include/cxx_project.sh"



while getopts lL:m name
do
    case $name in    
    l)  USR_BIN_PATH="/usr/local/bin"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        sudo ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log
        aval="$OPTARG";;
    L)  USR_BIN_PATH="$OPTARG"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        sudo ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log
        aval="$OPTARG";;
    m)  make_project  
        bflag=1
        bval="$OPTARG";;
    ?)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2;;
    esac
done
