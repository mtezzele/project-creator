
# Project Creator

Copyright (C) 2015 by Mauro Bardelloni and Marco Tezzele.

## Description

The repository contains some bash script to create the initial files to start a project in C++. Moreover it creates prototypes of classes and a ready to use CMakeLists.txt.

There is a script for gnuplot too. It generates a pdf plot reading all the parameters from file.

If you find this collection useful, feel free to download, use it and suggest pull requests!

The official distribution is on GitHub, and you can clone the repository using

	git clone https://github.com/mtezzele/project-creator.git

This file is subject to LGPL version 2.1 or later and may not be distributed without copyright and license information. Please refer to section License Information of this file for further information on this license.


## Usage

The two main scripts are cxxlib.sh and make_plot.sh.

### For the impatiens

You can run the cxxlib script using

	./cxxlib.sh -m
    
and write the author name, the project name and the name of the classes (in lower case) you want to create, when asked.

It will create the following tree:

	project_name/
    	CMakeLists.txt
        build/
    	source/
        	main.cc
            class_name_1.cc
            class_name_2.cc
            ...
        include/
        	class_name_1.h
            class_name_2.h
            ...
        tests/
        	CMakeLists.txt
        	test_01.cc
            test_01.output
            
Then you can complete the constructor of each class and you are ready to compile and run your entire project using:

	cd build
    cmake ..
    make
	make run


### For the others

Given that you have already read the previous section, you can specify also the compilation flags with the two commands

	make debug
    make release
    
the first compiles in debug mode (-g -DDEBUG) and the second in optimized mode (-O3).
   
For information about all the possible options that cxxlib accepts, run the script as follow:

	./cxxlib.sh -h

A complete description will follow in the next days.


## License Information

See the LICENCE file in this directory.


