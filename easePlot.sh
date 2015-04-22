#!/bin/bash

MAKE_PLOT_CREATOR_PATH=$(echo -e $(readlink `which easePlot`) | sed "s/easePlot.sh//")
if [ -f $MAKE_PLOT_CREATOR_PATH ]
then
    MAKE_PLOT_CREATOR_PATH="./"
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

while getopts "lL:gh" name
do
    case $name in  
    h)  echo -e "$BAR"
        echo -e "$BAR"
        echo -e " FLAGS:"
        echo -e "\t -l        : Create a symbolic link to easePlot in /usr/local/bin"
        echo -e "\t -L [path] : Create a symbolic link to easePlot in path"
        echo -e "\t -g        : Generate a new .conf file in ./_conf/"
        echo -e " "
        echo -e "\t ATTENTION!  Every argument has to be included in \"...\" "
        echo -e "$BAR"
        echo -e "$BAR" 
        ;;
    l)  USR_BIN_PATH="/usr/local/bin"
        title "Creating a symbolic link to easePlot in $USR_BIN_PATH"
        ln -s $PWD/easePlot.sh $USR_BIN_PATH/easePlot 2>> $MAKE_PLOT_CREATOR_PATH/_log/getops.log 
        ;;
    L)  USR_BIN_PATH="$OPTARG"
        title "Creating a symbolic link to easePlot in $USR_BIN_PATH"
        ln -s $PWD/easePlot.sh $USR_BIN_PATH/easePlot 2>> $MAKE_PLOT_CREATOR_PATH/_log/getops.log 
        ;;
    g)  generate_conf
        ;;
    :)  printf "Usage: %s: [-l] [-L args] [-g] [-h] \n" $0
        exit 2 ;;
    \?)  printf "Usage: %s: [-l] [-L args] [-g] [-h] \n" $0
        exit 2 ;;
    esac
done