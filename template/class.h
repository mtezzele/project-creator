#ifndef __##DEF_CLASS##__
#define __##DEF_CLASS##__


#include <iostream>
#include <vector>


template <int dim, int spacedim=dim>
class ##CLASS##
{
public:
	##CLASS## ();
	~##CLASS## ();
	
	void print(std::ostream &out = std::cout) const;
private:
	
};

#endif