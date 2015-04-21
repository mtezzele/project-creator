#!/bin/bash

source "include/gnuplot.sh"

file="newton.dat"
y_label="sqrt(x)"
x_label="x"
xxrange="[0.2:20]"
yyrange="[0:12]"
title="sqrt with Newton"
output="sqrt_00.pdf"
what="	$file using  2:3 title 'sqrt' with lines "
plot