#!/bin/bash

# Authors: Marco Tezzele and Mauro Bardelloni
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $AUTHOR is the author of the project
# $PROJECT_NAME is the name of the project
# $CLASSES is the name of the classes (in lower case)

CXXLIB_CREATOR_PATH=$(echo -e $(readlink `which cxxlib`) | sed "s/cxxlib.sh//")
if [ -f $CXXLIB_CREATOR_PATH ]
then
    CXXLIB_CREATOR_PATH="./"
fi

source "$CXXLIB_CREATOR_PATH/include/utilities.sh"
source "$CXXLIB_CREATOR_PATH/include/cxx_project.sh"

MAKE_PROJECT_CHECK=false

if [ ! -d "log" ]; then
    mkdir "log"
fi

AUTHOR="author"
PROJECT_NAME="project"
CLASSES="classes"

while getopts ":lL:mha:p:c:" name
do
    case $name in  
    h)  echo -e "$BAR"
        echo -e "$BAR"
        echo -e " FLAGS:"
        echo -e "\t -l        : Create a symbolic link to cxxlib in /usr/local/bin"
        echo -e "\t -L [path] : Create a symbolic link to cxxlib in path"
        echo -e "\t -m        : Create a new project"
        echo -e "\t -a [path] : Author of the project"
        echo -e "\t -p [path] : Name of the project"
        echo -e "\t -c [path] : Classes of the project"
        echo -e " "
        echo -e "\t ATTENTION!  Every argument has to be included in \"...\" "
        echo -e "$BAR"
        echo -e "$BAR" 
        ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        echo -e "CXXLIB_CREATOR_PATH=$PWD" > include/params.prm
        ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log 
        ;;
    L)  USR_BIN_PATH="$OPTARG"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        echo -e "CXXLIB_CREATOR_PATH=$PWD" > include/params.prm
        ln -s $PWD/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> log/getops.log 
        ;;
    a)  AUTHOR="$OPTARG"
        echo -e "$AUTHOR"
        ;;
    p)  PROJECT_NAME="$OPTARG"
        ;;
    c)  CLASSES="$OPTARG"   
        ;;
    m)  MAKE_PROJECT_CHECK=true
        ;;
    :)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    \?)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    esac
done

if [ "$MAKE_PROJECT_CHECK" == true ]
then
    echo -e "$BAR"
    echo -e "  CREATING THE PROJECT"
    echo -e "$BAR"
    make_project "$AUTHOR" "$PROJECT_NAME" "$CLASSES"
    print_report
fi