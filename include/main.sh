#!/bin/bash

function make_main
{
    # Generating the main.cc file
    cat "./template/header_main.tmp"   >    $2/source/main.cc
    cat "./template/main_1.cc"         >>   $2/source/main.cc
    cat "./template/include_class.tmp" >>   $2/source/main.cc
    cat "./template/main_2.cc"         >>$2/source/main.cc
}
export -f make_main