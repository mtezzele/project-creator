#!/bin/bash

function make_main
{
    # main file
    echo -e "/*
     * Usage:
     * cd build
     * cmake ..
     * make
     * make run
     *
     * Description
     *$1
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
    " >> $2/source/main.cc
}
export -f make_main