#!/bin/bash

# Author: Marco Tezzele
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $AUTHOR is the author of the project
# $PROJECT_NAME is the name of the project
# $CLASS is the name of the first class (in lower case)

# Creation of the name of the class
echo 
read -e -p "Author: ................. " AUTHOR
read -e -p "Name of the project: .... " PROJECT_NAME
read -e -p "Name of the class: ...... " CLASS

CLASS=`echo -e ${CLASS:0:1} | tr '[a-z]' '[A-Z]'`${CLASS:1}
DATE=`date "+date: %Y-%m-%d"` 
TIME=`date "+time: %H:%M:%S"`
# filesystem creation
mkdir $PROJECT_NAME $PROJECT_NAME/include $PROJECT_NAME/source $PROJECT_NAME/build


# main file
echo -e "/*
 * Usage:
 * cd build
 * cmake ..
 * make
 * make run
 *
 * Description
 *
 * Author: $AUTHOR
 * $DATE
 * $TIME
 */


#include <iostream>
#include <cmath>
#include <vector>
#include <cstdlib>
#include <time.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/time.h>


#include \"$CLASS.h\"

/* Returns elapsed seconds past from the last call to timer rest */
double cclock()
{
    struct timeval tmp;
    double sec;
    gettimeofday( &tmp, (struct timezone *)0 );
    sec = tmp.tv_sec + ((double)tmp.tv_usec)/1000000.0;
    return sec;
}


int main(int argc, char *argv[])
{

	return 0;
}
" >> $PROJECT_NAME/source/main.cc


# source file of the class
echo -e "/*
 * Author: $AUTHOR
 * Last edit: 00-00-201
 */

#include <iostream>
#include <vector>
#include <cmath>

#include \"$CLASS.h\"


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
" >> $PROJECT_NAME/source/$CLASS.cc


# header file of the class
echo -e "/*
 * Author: $AUTHOR
 * $DATE
 * $TIME
 * Last edit: 00-00-201
 */

#ifndef __$CLASS__
#define __$CLASS__

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
" >> $PROJECT_NAME/include/$CLASS.h


# cmake file with MPI and OMP
echo -e 'cmake_minimum_required(VERSION 2.8)

project ('$PROJECT_NAME')
file(GLOB cc_files source/*.cc)
include_directories(include)
add_executable('$PROJECT_NAME' ${cc_files})



find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})

target_link_libraries('$PROJECT_NAME' ${MPI_LIBRARIES})

if(MPI_COMPILE_FLAGS)
  set_target_properties('$PROJECT_NAME' PROPERTIES
    COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
endif()

if(MPI_LINK_FLAGS)
  set_target_properties('$PROJECT_NAME' PROPERTIES
    LINK_FLAGS "${MPI_LINK_FLAGS}")
endif()


find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()


add_custom_target(run
    COMMAND '$PROJECT_NAME'
    DEPENDS '$PROJECT_NAME'
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
)' >> $PROJECT_NAME/CMakeLists.txt

