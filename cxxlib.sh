#!/bin/bash

# Authors: Marco Tezzele and Mauro Bardelloni
# Last edit: 29-03-2015

# It creates a complete filesystem for a c++ project.
# $AUTHOR is the author of the project
# $PROJECT_NAME is the name of the project
# $CLASSES is the name of the classes (in lower case)

source include/function.sh

# Creation of the name of the class
echo 
read -e -p "Author: ................. " AUTHOR
read -e -p "Name of the project: .... " PROJECT_NAME
read -e -p "Name of the class: ...... " CLASSES

DATE=`date "+date: %Y-%m-%d"` 
TIME=`date "+time: %H:%M:%S"`
# filesystem creation
mkdir $PROJECT_NAME $PROJECT_NAME/include $PROJECT_NAME/source $PROJECT_NAME/build

INCLUDE=`for CLASS in $CLASSES; do echo "#include \"$CLASS.h\""; done`
HEADER=`echo -e "\n 	* Author: $AUTHOR\n\t * $DATE\n\t * $TIME\n"`

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

$INCLUDE


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

for CLASS in $CLASSES
do
    make_class "$CLASS" "$PROJECT_NAME/source" "$PROJECT_NAME/include" "$HEADER"
done

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

