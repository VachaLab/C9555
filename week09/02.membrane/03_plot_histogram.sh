#!/bin/bash

# calculate the histogram using the cats module
module add cats

histogram COLS_WATER HIST_WATER -l -0.5 -r 0.5 -c 2 -s 21 -n --nbins 100
histogram COLS_IONS  HIST_IONS  -l -0.5 -r 0.5 -c 2 -s 21 -n --nbins 100

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST.png"

set grid

set yrange [-1:9]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_WATER' w l lc rgb "dark-blue" t "Water", \
     'HIST_IONS' w l lc rgb "dark-red" t "Sodium"
EOF

# show the image
display HIST.png
