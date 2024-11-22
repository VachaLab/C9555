#!/bin/bash

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST.png"

set grid

set yrange [0:]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_CATS' w l t "Cats", \
     'HIST_PLMD' w l t "Plumed", \
     'HIST_PYTH' w l t "Python"
EOF

# show the image
display HIST.png
