#!/bin/bash

function make_class
{
	CLASS=$1
	# source file of the class
	echo '/*
	 * Author: Marco Tezzele
	 * Last edit: 00-00-201
	 */
	#include <iostream>
	#include <vector>
	#include <cmath>
	#include "'$2'.h"
	template <int dim, int spacedim>
	'$CLASS'<dim,spacedim>::'$CLASS '()
	:
	(),
	()
	{}
	template <int dim, int spacedim>
	'$CLASS'<dim,spacedim>::~'$CLASS '()
	{}
	template <int dim, int spacedim>
	void '$CLASS'<dim,spacedim>::print(std::ostream &out) const
	{
		out << std::endl;
		return;
	}
	// explicit instantiations
	template class '$CLASS'<1,1>;
	template class '$CLASS'<1,2>;
	template class '$CLASS'<2,2>;
	template class '$CLASS'<1,3>;
	template class '$CLASS'<2,3>;
	template class '$CLASS'<3,3>;
	' >> "$2/$1.cc"


	# header file of the class
	echo '/*
	 * Author: Marco Tezzele
	 * Last edit: 00-00-201
	 */
	#ifndef __'$2'__
	#define __'$2'__
	#include <iostream>
	#include <vector>
	template <int dim, int spacedim=dim>
	class '$CLASS'
	{
	public:
		'$CLASS '();
		~'$CLASS '();
		
		void print(std::ostream &out = std::cout) const;
	private:
		
	};
	#endif
	' >> "$3/$1.h"
}
export -f make_class