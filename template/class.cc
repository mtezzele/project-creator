#include <iostream>
#include <vector>
#include <cmath>
#include "##HEADER##.h"


template <int dim, int spacedim>
##CLASS##<dim,spacedim>::##CLASS## ()
:
(),
()
{}


template <int dim, int spacedim>
##CLASS##<dim,spacedim>::~##CLASS## ()
{}


template <int dim, int spacedim>
void ##CLASS##<dim,spacedim>::print(std::ostream &out) const
{
	out << std::endl;
	return;
}


// explicit instantiations
template class ##CLASS##<1,1>;
template class ##CLASS##<1,2>;
template class ##CLASS##<2,2>;
template class ##CLASS##<1,3>;
template class ##CLASS##<2,3>;
template class ##CLASS##<3,3>;