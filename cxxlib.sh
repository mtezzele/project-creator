#!/bin/bash

# Author: Marco Tezzele
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $1 is the name of the project
# $2 is the name of the first class (in lower case)

# Creation of the name of the class
CLASS=$2
CLASS=`echo ${CLASS:0:1} | tr  '[a-z]' '[A-Z]'`${CLASS:1}

# filesystem creation
mkdir $1 $1/include $1/source $1/build


# main file
echo '/*
 * Usage:
 * cd build
 * cmake ..
 * make
 * make run
 *
 * Description
 *
 * Author: Marco Tezzele
 * Last edit: 00-00-201
 */


#include <iostream>
#include <cmath>
#include <cstdlib>
#include <time.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/time.h>


#include "'$2'.h"

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
' >> $1/source/main.cc


# source file of the class
echo '/*
 * Author: Marco Tezzele
 * Last edit: 00-00-201
 */

#include <iostream>
#include <vector>
#include <cmath>

#include "'$2'.h"

'$CLASS'::'$CLASS '()
:
(),
()
{}


'$CLASS'::~'$CLASS '()
{}


void '$CLASS'::print(std::ostream &out) const
{
	out << std::endl;

	return;
}' >> $1/source/$2.cc


# header file of the class
echo '/*
 * Author: Marco Tezzele
 * Last edit: 00-00-201
 */

#ifndef __'$2'__
#define __'$2'__

#include <iostream>

class '$CLASS'
{
public:
	'$CLASS '();
	~'$CLASS '();
	
	void print(std::ostream &out = std::cout) const;

private:
	
};

#endif
' >> $1/include/$2.h


# cmake file with MPI and OMP
echo 'cmake_minimum_required(VERSION 2.8)

project ('$1')
file(GLOB cc_files source/*.cc)
include_directories(include)
add_executable('$1' ${cc_files})



find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})

target_link_libraries('$1' ${MPI_LIBRARIES})

if(MPI_COMPILE_FLAGS)
  set_target_properties('$1' PROPERTIES
    COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
endif()

if(MPI_LINK_FLAGS)
  set_target_properties('$1' PROPERTIES
    LINK_FLAGS "${MPI_LINK_FLAGS}")
endif()


find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()


add_custom_target(run
    COMMAND '$1'
    DEPENDS '$1'
    WORKING_DIRECTORY ${CMAKE_PROJECT_DIR}
)' >> $1/CMakeLists.txt

