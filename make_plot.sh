#!/bin/bash

source "include/gnuplot.sh"


MAKE_PLOT_CREATOR_PATH=$(echo -e $(readlink `which make_plot`) | sed "s/make_plot.sh//")
if [ -f $MAKE_PLOT_CREATOR_PATH ]
then
    MAKE_PLOT_CREATOR_PATH="./"
fi

generate_conf

# file="newton.dat"
# y_label="sqrt(x)"
# x_label="x"
# xxrange="[0.2:20]"
# yyrange="[0:12]"
# title="sqrt with Newton"
# output="sqrt_00.pdf"
# what="	$file using  2:3 title 'sqrt' with lines "
# plot