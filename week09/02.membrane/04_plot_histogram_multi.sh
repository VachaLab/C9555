#!/bin/bash

# calculate the histogram using the cats module
module add cats

# collect the data for the first 10 water/sodium beads
awk '/#/ {next} {for (i=2; i<=NF; ++i) printf "%f\n", $i}' COLS_WATER > WAT
awk '/#/ {next} {for (i=2; i<=NF; ++i) printf "%f\n", $i}' COLS_IONS  > SOD
histogram WAT HIST_WATER_MULTI -l -0.5 -r 0.5 -c 1 -s 0 -n --nbins 100
histogram SOD HIST_IONS_MULTI  -l -0.5 -r 0.5 -c 1 -s 0 -n --nbins 100

# remove the temporary files
rm -f WAT SOD

# plot the data using gnuplot
gnuplot << EOF
set terminal pngcairo
set output "HIST_MULTI.png"

set grid

set yrange [-1:9]

set xlabel "Scaled Distance"
set ylabel "Frequency"

plot 'HIST_WATER_MULTI' w l lc rgb "dark-blue" t "Water", \
     'HIST_IONS_MULTI' w l lc rgb "dark-red" t "Sodium"
EOF

# show the image
display HIST_MULTI.png
