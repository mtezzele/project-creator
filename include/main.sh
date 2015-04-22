#!/bin/bash

function make_main
{
    # Generating the main.cc file
    cat "./template/header_main.tmp"   >    $2/source/main.cc
    cat "./template/main_1.cc"         >>   $2/source/main.cc
    cat "./template/include_class.tmp" >>   $2/source/main.cc
    cat "./template/main_2.cc"         >>$2/source/main.cc
}
export -f make_main

function make_cmake
{
    # cmake file with MPI and OMP
    cat "./template/CMakeLists.txt" | sed "s/##PROJECT##/$1/" > $1/CMakeLists.txt
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