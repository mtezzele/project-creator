#!/bin/bash

function make_main
{
    # Generating the main.cc file
    cat "$CXXLIB_CREATOR_PATH/template/header_main.tmp"   >    $2/source/main.cc
    cat "$CXXLIB_CREATOR_PATH/template/main_1.cc"         >>   $2/source/main.cc
    cat "$CXXLIB_CREATOR_PATH/template/include_class.tmp" >>   $2/source/main.cc
    cat "$CXXLIB_CREATOR_PATH/template/main_2.cc"         >>   $2/source/main.cc
}
export -f make_main

function make_cmake
{
    # cmake file with MPI and OMP
    cat "$CXXLIB_CREATOR_PATH/template/CMakeLists.txt" | sed "s/##PROJECT##/$1/" > $1/CMakeLists.txt
}
export -f make_cmake

function make_class
{
	# This function create the files for the class: source and header 

	CLASS=$1
	CLASS=`echo -e ${CLASS:0:1} | tr '[a-z]' '[A-Z]'`${CLASS:1}
	
	
	# Source Files:
	cat "template/header_file.tmp" 	> "$2/$1.cc"
	cat "template/class.cc" | sed "s/##HEADER##/$1/" \
							| sed "s/##CLASS##/$CLASS/" >> "$2/$1.cc"

	# Header files:
	cat "template/header_file.tmp" 	> "$3/$1.h"
							
	cat "template/class.h" 	| sed "s/##DEF_CLASS##/$1/" \
							| sed "s/##CLASS##/$CLASS/" >> "$3/$1.h"
}
export -f make_class

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
	if [ ! -d "$PROJECT_NAME" ]; 
	then
		mkdir "$PROJECT_NAME"
	else
		if [ "$4" == "true" ]
		then
			rm -rf "$PROJECT_NAME/*"
		fi
	fi
	
	for DIR in "$PROJECT_NAME/include" "$PROJECT_NAME/source" "$PROJECT_NAME/build"
	do
		if [ ! -d "$DIR" ];
		then
			mkdir "$DIR"
		fi
	done

	INCLUDE=`for CLASS in $CLASSES; do echo "#include \"$CLASS.h\""; done`
	echo -e "$INCLUDE" > "$CXXLIB_CREATOR_PATH/template/include_class.tmp"
	echo -e "\n/*\n * Author: $AUTHOR\n * $DATE\n * $TIME\n */ \n\n " > "$CXXLIB_CREATOR_PATH/template/header_file.tmp"
	echo -e "\n/*\n * Usage:\n * cd build\n * cmake ..\n * make\n * make run\n *\n * Description\n * Author: $AUTHOR\n * $DATE\n * $TIME\n */ \n\n " > "$CXXLIB_CREATOR_PATH/template/header_main.tmp"

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

function usage
{
    echo -e "$BAR"
    echo -e "$BBAR"
	echo -e " "
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
	echo -e " "
    echo -e "$BBAR"
    echo -e "$BAR" 
}
export -f usage