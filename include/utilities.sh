#!/bin/bash

if [ ! -f "$CXXLIB_CREATOR_PATH" ]
then
	source "$CXXLIB_CREATOR_PATH/include/color.sh"
elif [ ! -f "$MAKE_PLOT_CREATOR_PATH" ]
then
	source "$MAKE_PLOT_CREATOR_PATH/include/color.sh"
fi
	
BAR="=============================================================================="
BBAR="------------------------------------------------------------------------------"

function title
{
	echo -e "${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}${GREEN_COLOR}"
	echo -e "  ${RED_COLOR}${1}${CLOSE_COLOR}" 
	echo -e "${CLOSE_COLOR}${HIGH_RED_COLOR}${BAR}${CLOSE_COLOR}"
}
export -f title

function sub_title
{
	echo -e "${HIGH_BLUE_COLOR}${BAR}${CLOSE_COLOR}"
	echo -e "  ${BLUE_COLOR}${1}${CLOSE_COLOR}" 
	echo -e "${HIGH_BLUE_COLOR}${BAR}${CLOSE_COLOR}"
}
export -f title