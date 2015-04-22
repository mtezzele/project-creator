#!/bin/bash

function make_class
{
	# This function create the files for the class: source and header 

	CLASS=$1
	CLASS=`echo -e ${CLASS:0:1} | tr '[a-z]' '[A-Z]'`${CLASS:1}
	
	
	# Source Files:
	cat "template/header_file.tmp" 	> "$2/$1.cc"
	cat "template/class.cc" | sed "s/##HEADER##/$1/" \
							| sed "s/##CLASS##/$CLASS/" >> "$3/$1.h"

	# Header files:
	cat "template/header_file.tmp" 	> "$3/$1.h"
							
	cat "template/class.h" 	| sed "s/##DEF_CLASS##/$1/" \
							| sed "s/##CLASS##/$CLASS/" >> "$3/$1.h"
}
export -f make_class