#!/bin/bash

source "include/class.sh"
source "include/cmake.sh"
source "include/main.sh"

function make_project
{
	# Creation of the name of the class
	echo 
	read -e -p "Author: ................. " AUTHOR
	read -e -p "Name of the project: .... " PROJECT_NAME
	read -e -p "Name of the class: ...... " CLASSES

	DATE=`date "+date: %Y-%m-%d"` 
	TIME=`date "+time: %H:%M:%S"`
	# filesystem creation
	mkdir $PROJECT_NAME $PROJECT_NAME/include $PROJECT_NAME/source $PROJECT_NAME/build

	INCLUDE=`for CLASS in $CLASSES; do echo "#include \"$CLASS.h\""; done`
	HEADER=`echo -e "\n\t * Author: $AUTHOR\n\t * $DATE\n\t * $TIME\n"`

	make_main "$HEADER" "$PROJECT_NAME"
	for CLASS in $CLASSES
	do
	    make_class "$CLASS" "$PROJECT_NAME/source" "$PROJECT_NAME/include" "$HEADER"
	done
	make_cmake "$PROJECT_NAME"
}
export -f make_project