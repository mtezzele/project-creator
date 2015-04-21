#!/bin/bash

source "include/gnuplot.sh"


MAKE_PLOT_CREATOR_PATH=$(echo -e $(readlink `which make_plot`) | sed "s/make_plot.sh//")
if [ -f $MAKE_PLOT_CREATOR_PATH ]
then
    MAKE_PLOT_CREATOR_PATH="./"
fi

while getopts "lL:gh" name
do
    case $name in  
    h)  echo -e "$BAR"
        echo -e "$BAR"
        echo -e " FLAGS:"
        echo -e "\t -l        : Create a symbolic link to make_plot in /usr/local/bin"
        echo -e "\t -L [path] : Create a symbolic link to make_plot in path"
        echo -e "\t -g        : Generate a new .conf file in ./_conf/"
        echo -e " "
        echo -e "\t ATTENTION!  Every argument has to be included in \"...\" "
        echo -e "$BAR"
        echo -e "$BAR" 
        ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to make_plot in $USR_BIN_PATH"
        echo -e "$BAR"
        ln -s $PWD/make_plot.sh $USR_BIN_PATH/make_plot 2>> _log/getops.log 
        ;;
    L)  USR_BIN_PATH="$OPTARG"
        echo -e "$BAR"
        echo -e " Creating a symbolic link to make_plot in $USR_BIN_PATH"
        echo -e "$BAR"
        ln -s $PWD/make_plot.sh $USR_BIN_PATH/make_plot 2>> _log/getops.log 
        ;;
    g)  generate_conf
        ;;
    :)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    \?)  printf "Usage: %s: [-l] [-m] \n" $0
        exit 2 ;;
    esac
done