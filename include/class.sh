#!/bin/bash

function make_class
{
	CLASS=$1
	CLASS=`echo -e ${CLASS:0:1} | tr '[a-z]' '[A-Z]'`${CLASS:1}
	# source file of the class
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


	# header file of the class
	echo "/*
	 $4
	 */
	
	#ifndef __$1__
	#define __$1__

	
	#include <iostream>
	#include <vector>
	

	template <int dim, int spacedim=dim>
	class $CLASS
	{
	public:
		$CLASS ();
		~$CLASS ();
		
		void print(std::ostream &out = std::cout) const;
	private:
		
	};
	
	#endif
	" >> "$3/$1.h"
}
export -f make_class