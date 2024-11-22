#!/bin/bash

module add gromacs:2022.3-plumed

# remove files from previous runs
rm -f HIST_PLMD_T* core bck.*

# run the trajectory analysis
plumed driver --plumed data/plumed_3.dat --mf_xtc data/prod.xtc

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST_TIME.png"

set grid

set yrange [0:]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_PLMD_T1' w l lw 1.0 lc rgb "dark-green" t "250 frames" , \
     'HIST_PLMD_T2' w l lw 1.5 lc rgb "orange" t "500 frames", \
     'HIST_PLMD_T3' w l lw 2.0 lc rgb "red" t "750 frames", \
     'HIST_PLMD_T4' w l lw 3.0 lc rgb "dark-red" t "1000 frames"
EOF

# show the output image
display HIST_TIME.png
