#!/bin/bash

function make_cmake
{
  # cmake file with MPI and OMP
  cat "./template/CMakeLists.txt" | sed "s/##PROJECT##/$1/" > $1/CMakeLists.txt
}
export -f make_cmake