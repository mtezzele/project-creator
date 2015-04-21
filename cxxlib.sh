#!/bin/bash

# Authors: Marco Tezzele and Mauro Bardelloni
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $AUTHOR is the author of the project
# $PROJECT_NAME is the name of the project
# $CLASSES is the name of the classes (in lower case)

source "include/utilities.sh"
source "include/cxx_project.sh"

if [ ! -d "log" ]; then
    mkdir "log"
fi

while getopts lL:mh name
do
    case $name in  
    h)  echo -e "$BAR"
        echo -e "$BAR"
        echo -e " FLAGS:"
        echo -e "\t -l        : Create a symbolic link to cxxlib in /usr/local/bin"
        echo -e "\t -L [path] : Create a symbolic link to cxxlib in path"
        echo -e "\t -m        : Create a new project"
        echo -e "$BAR"
        echo -e "$BAR" ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        sudo ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log ;;
    L)  USR_BIN_PATH="$OPTARG"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        sudo ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log ;;
    m)  make_project;;
    *)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    ?)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    esac
done
