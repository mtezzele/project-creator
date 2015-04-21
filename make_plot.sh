#!/bin/bash

function plot()
{
	gnuplot -e "
		set term png;
		set output \"${output}\"; 
		set ylabel \"${y_label}\";
		set xlabel \"${x_label}\";
		set xrange ${xxrange};
		set yrange ${yyrange};
		set format x \"%g\";
		set title \"${title}\";
		plot ${what} "
}


file="newton.dat"
y_label="sqrt(x)"
x_label="x"
xxrange="[0.2:20]"
yyrange="[0:12]"
title="sqrt with Newton"
output="sqrt_00.png"
what="	\"newton.dat\" using  2:3 title 'sqrt' with lines "
plot