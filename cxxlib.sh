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
source "$CXXLIB_CREATOR_PATH/include/color.sh"
source "$CXXLIB_CREATOR_PATH/include/cxx_project.sh"

clear
echo -e "${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}"
while read -r line
do
    name=$line
    echo -e "${HIGH_GREEN_COLOR}${line}" | tr "." " "
done < "$CXXLIB_CREATOR_PATH/template/title_cxxlib.txt"
echo -e "\n${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}\n\n"

MAKE_PROJECT_CHECK=false
MAKE_PROJECT_OVERWRITE=false

if [ ! -d "_log" ]; 
then
    mkdir "_log"
fi

AUTHOR="author"
PROJECT_NAME="project"
CLASSES="classes"

while getopts ":lL:mMha:p:c:" name
do
    case $name in  
    h)  echo -e "$BAR"
        echo -e "$BAR"
        echo -e " FLAGS:"
        echo -e "\t -l          : Create a symbolic link to cxxlib in /usr/local/bin"
        echo -e "\t -L [path]   : Create a symbolic link to cxxlib in path"
        echo -e "\t -m          : Create a new project"
        echo -e "\t -M          : Create a new project (if it exists overwrite the older)"
        echo -e "\t -a [name/s] : Author/s of the project"
        echo -e "\t -p [name]   : Name of the project"
        echo -e "\t -c [name/s] : Classes of the project"
        echo -e " "
        echo -e "\t ATTENTION!  For multiple arguments use quotation marks \" \" "
        echo -e "$BAR"
        echo -e "$BAR" 
        ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        ln -s $CXXLIB_CREATOR_PATH/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> ./_log/getops.log 
        ;;
    L)  USR_BIN_PATH="$OPTARG"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to cxxlib in $USR_BIN_PATH"
        echo -e "$BAR"
        ln -s $CXXLIB_CREATOR_PATH/cxxlib.sh $USR_BIN_PATH/cxxlib 2>> ./_log/getops.log 
        ;;
    a)  AUTHOR="$OPTARG"
        MAKE_PROJECT_CHECK=true
        ;;
    p)  PROJECT_NAME="$OPTARG"
        MAKE_PROJECT_CHECK=true
        ;;
    c)  CLASSES="$OPTARG"   
        MAKE_PROJECT_CHECK=true
        ;;
    M)  MAKE_PROJECT_CHECK=true
        MAKE_PROJECT_OVERWRITE=true
        ;;    
    m)  MAKE_PROJECT_CHECK=true
        ;;
    :)  printf "Usage: %s: [-l] [-L args] [-m] [-M] [-h] [-a args] [-p args] [-c args] \n" $0
        exit 2 ;;
    \?) printf "Usage: %s: [-l] [-L args] [-m] [-M] [-h] [-a args] [-p args] [-c args] \n" $0
        exit 2 ;;
    esac
done

if [ "$MAKE_PROJECT_CHECK" == true ]
then
    title "CREATING THE PROJECT"
    make_project "$AUTHOR" "$PROJECT_NAME" "$CLASSES" "$MAKE_PROJECT_OVERWRITE"
    print_report
fi

rm -f ${CXXLIB_CREATOR_PATH}template/*.tmp