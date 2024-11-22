#!/bin/bash

# calculate the histogram using the cats module
module add cats

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo

unset key
set grid

set yrange [-0.5:0.5]

set xlabel "Scaled Distance"
set ylabel "Frequency"

set output "COLS_WATER.png"
plot for [i=2:11] 'COLS_WATER' w p pt 7 lc rgb "dark-blue"

set output "COLS_IONS.png"
plot for [i=2:11] 'COLS_IONS' w p pt 7 lc rgb "dark-red"
EOF

# show the images
display COLS_WATER.png &
display COLS_IONS.png
