#!/bin/bash

function make_class
{
	CLASS=$1
	CLASS=`echo -e ${CLASS:0:1} | tr '[a-z]' '[A-Z]'`${CLASS:1}
	# source file of the class
	
	cat "template/header_file.tmp" 	> "$2/$1.cc"
	echo "
	/*$4
	 */

	#include <iostream>
	#include <vector>
	#include <cmath>
	#include \"$1.h\"
	

	template <int dim, int spacedim>
	$CLASS<dim,spacedim>::$CLASS ()
	:
	(),
	()
	{}


	template <int dim, int spacedim>
	$CLASS<dim,spacedim>::~$CLASS ()
	{}
	

	template <int dim, int spacedim>
	void $CLASS<dim,spacedim>::print(std::ostream &out) const
	{
		out << std::endl;
		return;
	}
	

	// explicit instantiations
	template class $CLASS<1,1>;
	template class $CLASS<1,2>;
	template class $CLASS<2,2>;
	template class $CLASS<1,3>;
	template class $CLASS<2,3>;
	template class $CLASS<3,3>;
	" >> "$2/$1.cc"


	cat "template/header_file.tmp" 	> "$3/$1.h"
							
	cat "template/class.h" 	| sed "s/##DEF_CLASS##/$1/" \
							| sed "s/##CLASS##/$CLASS/" >> "$3/$1.h"
}
export -f make_class