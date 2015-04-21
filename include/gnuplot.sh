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
export -f function