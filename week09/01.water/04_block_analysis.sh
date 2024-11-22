#!/bin/bash

module add gromacs:2022.3-plumed

# remove files from previous runs
rm -f HIST_PLMD_H* core bck.*

# run trajectory analysis
plumed driver --plumed data/plumed_2.dat --mf_xtc data/prod.xtc

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST_BLOCK.png"

set grid

set yrange [0:]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_PLMD_H1' w l t "First half", \
     'HIST_PLMD_H2' w l t "Second half"
EOF

# show the output image
display HIST_BLOCK.png
