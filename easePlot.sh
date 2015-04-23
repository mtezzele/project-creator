#!/bin/bash

MAKE_PLOT_CREATOR_PATH=$(echo -e $(readlink `which easePlot`) | sed "s/easePlot.sh//")
if [ -f $MAKE_PLOT_CREATOR_PATH ]
then
    MAKE_PLOT_CREATOR_PATH="${PWD}"
fi

source "$MAKE_PLOT_CREATOR_PATH/include/utilities.sh"
source "$MAKE_PLOT_CREATOR_PATH/include/color.sh"
source "$MAKE_PLOT_CREATOR_PATH/include/gnuplot.sh"

clear
echo -e "${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}"
while read -r line
do
    name=$line
    echo -e "${HIGH_GREEN_COLOR}${line}" | tr "." " "
done < "$MAKE_PLOT_CREATOR_PATH/template/title_ease_plot.txt"
echo -e "\n${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}\n\n"


if [ ! -d "_log" ]; 
then
    mkdir "_log"
fi


if [ -z "$1" ]
then
   usage
   exit
fi

while getopts "lL:gh" name
do
    case $name in  
    h)  usage
        ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        title "Creating a symbolic link to easePlot in $USR_BIN_PATH"
        ln -s $MAKE_PLOT_CREATOR_PATH/easePlot.sh $USR_BIN_PATH/easePlot 2>> $MAKE_PLOT_CREATOR_PATH/_log/getops.log 
        ;;
    L)  USR_BIN_PATH="$OPTARG"
        title "Creating a symbolic link to easePlot in $USR_BIN_PATH"
        ln -s $MAKE_PLOT_CREATOR_PATH/easePlot.sh $USR_BIN_PATH/easePlot 2>> $MAKE_PLOT_CREATOR_PATH/_log/getops.log 
        ;;
    g)  generate_conf
        ;;
    :)  usage
        ;;
    \?) usage
        ;;
    esac
done

