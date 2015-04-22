#!/bin/bash

source "include/class.sh"
source "include/cmake.sh"
source "include/main.sh"

function make_project
{
	AUTHOR="$1"
	PROJECT_NAME="$2"
	CLASSES="$3"
	# Creation of the name of the class
	if [ "$AUTHOR" == "author" ]
	then
		read -e -p "Author: ................. " AUTHOR
	fi
	if [ "$PROJECT_NAME"  == "project" ]
	then
		read -e -p "Name of the project: .... " PROJECT_NAME
	fi
	if [ "$CLASSES" == "classes" ]
	then
		read -e -p "Name of the class: ...... " CLASSES
	fi

	DATE=`date "+date: %Y-%m-%d"` 
	TIME=`date "+time: %H:%M:%S"`
	# filesystem creation
	mkdir $PROJECT_NAME $PROJECT_NAME/include $PROJECT_NAME/source $PROJECT_NAME/build

	INCLUDE=`for CLASS in $CLASSES; do echo "#include \"$CLASS.h\""; done`
	echo -e "\n\*\n * Author: $AUTHOR\n * $DATE\n * $TIME\n *\ \n\n " > "./template/header_file.tmp"

	make_main "$HEADER" "$PROJECT_NAME"
	for CLASS in $CLASSES
	do
	    make_class "$CLASS" "$PROJECT_NAME/source" "$PROJECT_NAME/include" "$HEADER"
	done
	make_cmake "$PROJECT_NAME"
}
export -f make_project

function print_report
{
	echo -e "$BAR"
	echo -e "$BBAR"
	echo -e " REPORT"
	echo -e " \t Author: ............. $AUTHOR"
	echo -e " \t Project name: ....... $PROJECT_NAME"
	echo -e " \t Classes: ............ $CLASSES"
	echo -e "$BBAR"
	echo -e "$BAR"
}
export -f print_report