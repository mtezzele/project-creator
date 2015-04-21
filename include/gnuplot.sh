#!/bin/bash

source "include/utilities.sh"

function plot
{
	gnuplot -e "
		set term pdf;
		set output \"${output}\"; 
		set ylabel \"${y_label}\";
		set xlabel \"${x_label}\";
		set xrange ${xxrange};
		set yrange ${yyrange};
		set format x \"%g\";
		set title \"${title}\";
		plot ${what} "
}
export -f plot

function generate_conf
{
	if [ ! -d "_conf" ]; 
	then
    	mkdir "_conf"
	fi
	
	title " Auto tool to generate .conf file"
	
	echo -e " -> Name of the file to generate (.conf)"
	read -p "   -> name: " FILE_NAME
	echo -e "$BBAR"
	FILE_NAME="./_conf/${FILE_NAME}.conf"
	
	echo -e " -> Chose which term do you prefer: \n\t 1) pdf [default] \n\t 2) png "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		2 ) echo -e "set term png;" >> "${FILE_NAME}"
			FILE_EXT="png"
			;;
		* ) echo -e "set term pdf;" >> "${FILE_NAME}"
			FILE_EXT="pdf"
			;;

	esac
	echo -e "$BBAR"
	
	echo -e " -> name of the file to generate"
	read -p "   -> name: " OUTPUT_FILE_NAME
	echo -e "set output \"${OUTPUT_FILE_NAME}.${FILE_EXT}\";" >> "${FILE_NAME}"
	echo -e "$BBAR"
	
	echo -e " -> xrange [Y]es or [n]o  "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		n )
			;;
		* ) echo -e " -> write the range (es. [-1.0:10.5])  "
			read -p "   -> your choice: " RANGE 
			echo -e "set xrange ${RANGE};" >> "${FILE_NAME}"
			;;

	esac
	echo -e "$BBAR"
	
	echo -e " -> yrange [Y]es or [n]o  "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		n ) 	
			;;
		* ) echo -e " -> write the range (es. [-1.0:10.5])  "
			read -p "   -> your choice: " RANGE 
			echo -e "set yrange ${RANGE};" >> "${FILE_NAME}"
			;;

	esac
	echo -e "$BBAR"
	
	echo -e " -> xlabel [Y]es or [n]o  "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		n ) 	
			;;
		* ) echo -e " -> write the title  "
			read -p "   -> your choice: " LABEL 
			echo -e "set xlabel \"${LABEL}\";" >> "${FILE_NAME}"
			;;
	esac
	echo -e "$BBAR"
	
	echo -e " -> ylabel [Y]es or [n]o  "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		n ) 	
			;;
		* ) echo -e " -> write the title  "
			read -p "   -> your choice: " LABEL 
			echo -e "set ylabel \"${LABEL}\";" >> "${FILE_NAME}"
			;;
	esac
	echo -e "$BBAR"
	
	echo -e " -> title [Y]es or [n]o  "
	read -p "   -> your choice: " CHOICE
	case "$CHOICE" in 
		n ) 	
			;;
		* ) echo -e " -> write the title  "
			read -p "   -> your choice: " LABEL 
			echo -e "set title \"${LABEL}\";" >> "${FILE_NAME}"
			;;
	esac
	echo -e "$BBAR"
	

}
export -f generate_conf